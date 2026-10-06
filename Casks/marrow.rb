cask "marrow" do
  arch arm: "arm64", intel: "x64"

  version "0.4.2"
  sha256 arm:   "1a0437003e62a31824582c503262acbf5213361b46e24463ba4e4d80372b2d36",
         intel: "c0bcf7530e7ad5081e05606e1f900721453135a6fc30d0648e1fd249d61a6045"

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
