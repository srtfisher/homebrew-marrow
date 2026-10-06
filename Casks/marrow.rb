cask "marrow" do
  arch arm: "arm64", intel: "x64"

  version "0.4.0"
  sha256 arm:   "4e16afd0a87418ef69c45da1cad9cfb2d37adb684203852303bb526efe97359d",
         intel: "41db9bfd2585570db2f02d8dd04513cf5953605853805b2973f1e57127f6bb42"

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
