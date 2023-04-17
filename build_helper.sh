#!/usr/bin/env sh

config_gpg(){
  echo "Config GPG ..."
  # Import GPG key
  if [ "GPG_PRIV_KEY" = "" ]; then
    println "ERROR: No GPG_PRIV_KEY defined"
    exit 200
  fi
  echo "${'$'}{GPG_PRIV_KEY}" > .priv_key.gpg
  gpg \
    --batch \
    --pinentry-mode loopback \
    --passphrase "${GPG_PRIV_KEY_PASS}" \
    --import .priv_key.gpg
  rm -f .priv_key.gpg

  # Create GPG Trust
  if [ "$GPG_OWNERTRUST" != "" ]; then
    echo "$GPG_OWNERTRUST" | gpg --import-ownertrust
  fi
}

verify_gpg() {
  gpg -k --keyid-format LONG
  gpg -K --keyid-format LONG
}

sign_gpg() {
  gpg \
    --batch \
    --pinentry-mode loopback \
    --passphrase "${GPG_PRIV_KEY_PASS}" \
    --local-user ${GPG_LOCAL_USER} \
    --output ${FILE_PATH}.sig \
    --detach-sig \
    --yes \
    ${FILE_PATH}
}