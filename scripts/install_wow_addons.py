import json
import shutil
import subprocess
import sys
from pathlib import Path

ADDON_DIR = Path(
    "/home/chud/Games/battlenet/drive_c/Program Files (x86)/World of Warcraft/_forever_/Interface/AddOns"
)
ADDONS: dict[str, str] = json.loads(
    Path("./wow-addons.json").read_text(encoding="utf-8")
)


def cope(s):
    sys.stdout.write(s)
    sys.stdout.flush()


def ok():
    sys.stdout.write(" OK\n")
    sys.stdout.flush()


def clean_up_shit():
    cope("Cleaning up existing files...")

    for xd in ADDON_DIR.iterdir():
        try:
            if xd.is_dir() and not xd.is_symlink():
                shutil.rmtree(xd)
            else:
                xd.unlink()
        except Exception:  # noqa: BLE001, S110
            pass
    ok()
    print()


def main():
    clean_up_shit()

    for name, url in ADDONS.items():
        print(f"Installing {name!r}...")

        cope(" - Downloading...")
        args = ["wget", url, "-O", "xd"]
        subprocess.run(args=args, cwd=ADDON_DIR, check=True, capture_output=True)
        ok()

        cope(" - Unpacking...")
        args = ["unzip", "xd"]
        subprocess.run(args=args, cwd=ADDON_DIR, check=True, capture_output=True)
        ok()

        cope(" - Gooning...")
        args = ["rm", "xd"]
        subprocess.run(args=args, cwd=ADDON_DIR, check=True, capture_output=True)
        ok()

    print(f"\n All done, installed/updated {len(ADDONS)} addons :)")


if __name__ == "__main__":
    main()
