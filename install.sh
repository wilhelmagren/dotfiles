#!/usr/bin/env bash

set -eou pipefail

SCRIPTDIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
INSTALLDIR="$SCRIPTDIR/scripts"

case "$(uname -s)" in
    Linux)
        if [[ ! -f /etc/os-release ]]; then
            echo "Unable to detect Linux distribution"
            exit 1
        fi

        source /etc/os-release
        OS="${ID,,}"
        ;;

    Darwin)
        OS="macos"
        ;;

    *)
        echo "Unsupported OS: $(uname -s)"
        exit 1
        ;;
esac

INSTALLER="$INSTALLDIR/${OS}-install.sh"

if [[ ! -f "$INSTALLER" ]]; then
    echo "No installer found for '$OS':"
    echo "  $INSTALLER"
    exit 1
fi

echo "Detected OS: $OS"
echo "Running: $INSTALLER"

exec "$INSTALLER" "$@"
