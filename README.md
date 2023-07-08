# Self hosted pages

These are some static pages and files that sometimes are useful during pentests.

## Setup

Clone this repository and it's submodules:
```bash
git clone --recurse-submodules https://github.com/six-two/self-hosted-static-pages.git
```

Or if you already did a normal clone, run this to download the submodules:
```bash
git submodule update --init --recursive
```

Then configure a **static** webserver to serve the files in `site/`.

### Security considerations

This repository includes third party tools and I do not guarantee, that they 
have no web shells.
So you should use a web server that is not configured to evaluate files (PHP, ASPX, etc), instead it should just serve them as static files.

You should also serve the site from a separate domain, that ideally is not connected to other productive sites (and not a subdomain of these sites).
This is because some functionality may be added that might execute arbitrary user supplied JavaScript code, which functionally means that Cross-Site Scripting attackes may exist on the site.
So use a separate domain, so that `localStorage`, cookies, etc from other apps are not in any danger.

### "Exposed sensitive files"

Some security scanners may say that the site has exposed `.git/` directories or configuration files.
That is technically true, but they are from public repositories, thus they do not disclose any secret information.
If you want / need to disable this for compliance purposes, just configure your web server to reject requests for:

- `.git/`
- files staring with a dot (like `.gitignore`)
- `*.md`
- `*.toml`
- `*.json`
- `Dockerfile`
- `LICENSE`
- whatever else the scanner finds

Or if you are not afraid to break stuff, allowlist certain file extensions:

- Any folders
- HTML and co: `*.js`, `*.html`, `*.css`
- Images: `*.jpg`, `*.jpeg`, `*.png`, `*.ico`, `*.svg`
- Fonts: `*.ttf`
