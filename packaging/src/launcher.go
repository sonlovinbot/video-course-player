// Pronunciation Workshop — local launcher.
// A tiny static web server (with HTTP Range support, so video seeking works)
// that serves the bundled app + videos and opens the default browser.
// No runtime dependencies: ships as a single native binary per OS.
package main

import (
	"fmt"
	"net"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"time"
)

// baseDir returns the folder that holds app/ and MP4/.
// It looks next to the executable, and (for macOS .app bundles) falls back to ../Resources.
func baseDir() string {
	exe, err := os.Executable()
	if err != nil {
		wd, _ := os.Getwd()
		return wd
	}
	dir := filepath.Dir(exe)
	if _, err := os.Stat(filepath.Join(dir, "app", "index.html")); err == nil {
		return dir
	}
	res := filepath.Join(dir, "..", "Resources")
	if _, err := os.Stat(filepath.Join(res, "app", "index.html")); err == nil {
		return res
	}
	return dir
}

func openBrowser(url string) {
	var cmd *exec.Cmd
	switch runtime.GOOS {
	case "darwin":
		cmd = exec.Command("open", url)
	case "windows":
		cmd = exec.Command("rundll32", "url.dll,FileProtocolHandler", url)
	default: // linux, etc.
		cmd = exec.Command("xdg-open", url)
	}
	_ = cmd.Start()
}

func main() {
	root := baseDir()

	// Listen on a free localhost port (localhost is a secure context → PWA + mic work).
	ln, err := net.Listen("tcp", "127.0.0.1:8123")
	if err != nil {
		ln, err = net.Listen("tcp", "127.0.0.1:0") // any free port
		if err != nil {
			fmt.Println("Cannot start local server:", err)
			fmt.Println("Press Enter to exit.")
			fmt.Scanln()
			return
		}
	}
	port := ln.Addr().(*net.TCPAddr).Port
	url := fmt.Sprintf("http://127.0.0.1:%d/app/", port)

	fs := http.FileServer(http.Dir(root)) // ServeContent → Range supported automatically
	mux := http.NewServeMux()
	mux.Handle("/", fs)

	fmt.Println("==============================================")
	fmt.Println(" Pronunciation Workshop is running.")
	fmt.Println(" Open this in your browser if it didn't open:")
	fmt.Println("   " + url)
	fmt.Println(" Keep this window open while studying.")
	fmt.Println(" Close it to stop the app.")
	fmt.Println("==============================================")

	go func() {
		time.Sleep(600 * time.Millisecond)
		openBrowser(url)
	}()

	if err := http.Serve(ln, mux); err != nil {
		fmt.Println("Server error:", err)
	}
}
