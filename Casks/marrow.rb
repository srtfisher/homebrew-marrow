cask "marrow" do
  arch arm: "arm64", intel: "x64"

  version "0.4.4"
  sha256 arm:   "386497476a9c030bb2e161b042ac31ca0bfde659049c84f66d00055e3d27d2dd",
         intel: "e409455e77f3dfd1d9ef061b3af5b3aa1d6398afa520076cd9dac4e482fe8e5d"

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
