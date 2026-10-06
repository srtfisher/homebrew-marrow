cask "marrow" do
  arch arm: "arm64", intel: "x64"

  version "0.4.3"
  sha256 arm:   "a401ef1002135eda6e15f4616331f51f05cd525c6c78ae00ffc473943f295a37",
         intel: "9e18df02a68f5d189075a0978e15ce41cad272b70bc821c41946633e4caa34ee"

  url "https://github.com/srtfisher/marrow-review/releases/download/v#{version}/marrow-#{version}-mac-#{arch}.zip"
  name "marrow"
  desc "Review large pull requests, abridged and grouped by intent"
  homepage "https://github.com/srtfisher/marrow-review"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura

  app "marrow.app"

  # Not notarized, so Gatekeeper refuses it while the quarantine flag is set.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-drs", "com.apple.quarantine", "{{appdir}}/marrow.app"],
        writable_paths: ["marrow.app"],
        writable_base:  :appdir
  end

  zap trash: "~/Library/Application Support/marrow"

  caveats <<~EOS
    marrow needs gh signed in, and Claude Code installed and signed in for reviews.
  EOS
end
