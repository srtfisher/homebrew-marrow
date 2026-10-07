cask "marrow" do
  arch arm: "arm64", intel: "x64"

  version "0.4.5"
  sha256 arm:   "948e03e9f911f7244a8a923614a366a99c13b285cb742a591dd1415b7efb2244",
         intel: "b54d8cdc40132be9985136e1583de5c2b6781018ef5218bcab06caf308c48a2c"

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
