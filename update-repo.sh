#!/bin/bash
set -e

DIST=stable
ARCH=amd64
COMP=main
KEY="15D644B0250C14E1DEC0D0EED5C7BB6739C103E3"

echo "📦 Scanning packages..."
dpkg-scanpackages pool /dev/null > dists/$DIST/$COMP/binary-$ARCH/Packages
gzip -kf dists/$DIST/$COMP/binary-$ARCH/Packages

echo "📝 Writing Release file..."
cat > dists/$DIST/Release <<EOF
Origin: LinuxJavaDebs
Label: Linux Java Applications
Suite: stable
Codename: stable
Architectures: $ARCH
Components: $COMP
Description: Generic Java applications packaged as Debian packages
EOF

cd dists/$DIST

echo "🔐 Signing repository..."
gpg --default-key "$KEY" -abs -o Release.gpg Release
gpg --default-key "$KEY" --clearsign -o InRelease Release

echo "✅ Repository updated"
