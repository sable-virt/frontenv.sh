#!/bin/sh

REQUIRE_NODE_VERSION="v6.9.5"

# remove node old installer
if [[ -e /var/db/receipts/org.nodejs.pkg.bom ]]; then
    echo 'remove old node packages ...';
    lsbom -f -l -s -pf /var/db/receipts/org.nodejs.pkg.bom \
    | while read i; do
      sudo rm /usr/local/${i}
    done
    sudo rm -rf /usr/local/lib/node \
         /usr/local/lib/node_modules \
         /var/db/receipts/org.nodejs.*
    sudo rm -rf ~/.npm
else
    echo 'Old Node package: OK'
fi

# remove node installer
if [[ -e /var/db/receipts/org.nodejs.node.pkg.bom ]]; then
    echo 'remove old node packages ...';
    lsbom -f -l -s -pf /var/db/receipts/org.nodejs.node.pkg.bom \
    | while read i; do
      sudo rm /usr/local/${i}
    done
    sudo rm -rf /usr/local/lib/node \
         /usr/local/lib/node_modules \
         /var/db/receipts/org.nodejs.*
    sudo rm -rf ~/.npm
else
    echo 'Node package: OK'
fi

# homebrew
if ! type brew >/dev/null 2>&1; then
  # some code...
  echo 'install homebrew ...';
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo 'Homebrew: OK'
fi

# nodebrew
if ! type nodebrew >/dev/null 2>&1; then
  # some code...
  echo 'install nodebrew ...';
  brew install nodebrew
else
    echo 'Nodebrew: OK'
fi

# node
if ! type node >/dev/null 2>&1; then
  # some code...
  nodebrew install $REQUIRE_NODE_VERSION
  nodebrew use $REQUIRE_NODE_VERSION
else
    echo 'Node: OK'
fi

# node version check
NODE_VERSION="$(node --version)"
if [[ "$NODE_VERSION" != "$REQUIRE_NODE_VERSION" ]]; then
    echo "install node $REQUIRE_NODE_VERSION ..."
    nodebrew install $REQUIRE_NODE_VERSION
    nodebrew use $REQUIRE_NODE_VERSION
else
    echo 'Node version: OK'
fi

# remove npm yarn
npm un yarn -g

# yarn
if ! type yarn >/dev/null 2>&1; then
  # some code...
  echo 'install yarn ...';
  brew install yarn
else
    echo 'yarn: OK'
fi