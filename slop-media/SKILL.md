---
name: slop-media
description: Upload screen recordings and screenshots and get a video/image markdown line to paste in PR bodies. Use when the user wants to share a demo video, record a test video, embed video in a PR, or share a screenshot image.
---

# slop-media skill — put videos + images in PR bodies

Upload a screen recording or screenshot, get back a `<video>` / `<img>` markdown line, paste it in the PR body. GitHub renders both inline.

## Setup (env)
```
SLOP_MEDIA_URL=https://slop-media-jemo69s-projects.vercel.app
SLOP_MEDIA_TOKEN=<ask owner — same value as the app's UPLOAD_TOKEN>
```

Install once (private repo, needs access): `npm install -g github:Jemo69/slop-media`. Zero deps, node 18+. Then persist config so env vars aren't needed every call:
```bash
slop-media setup --url https://slop-media-jemo69s-projects.vercel.app --token <SLOP_MEDIA_TOKEN>
# stored in ~/.config/slop-media/config.json (mode 600). Env vars override it when set.

## Upload and embed in PR body
```bash
SLOP_MEDIA_URL=... SLOP_MEDIA_TOKEN=... slop-media upload demo.mp4 --pr 123 --repo owner/repo
SLOP_MEDIA_URL=... SLOP_MEDIA_TOKEN=... slop-media upload shot.png --pr 123 --repo owner/repo
# output ends with a <video> (mp4/webm/mov) or <img> (png/jpg/gif/webp/avif) line — paste exactly that line into the PR body
```

Output gives three things:
- `view` — pretty watch page (`$SLOP_MEDIA_URL/w/<id>`, video player or image)
- `raw` — file bytes on R2 (public, free egress)
- a ready markdown line, e.g.
```html
<video src="https://pub-a14e3233c63f4fe79257ff018c886e81.r2.dev/pr-123/....mp4" width="100%" controls></video>
```
images return an `<img>` line instead:
```html
<img src="https://pub-a14e3233c63f4fe79257ff018c886e81.r2.dev/pr-123/....png" width="100%" />
```

## List / delete / stage
```bash
slop-media list --pr 123
slop-media delete <id>
slop-media stage demo.mp4   # local type/size check before uploading
```

## Rules
- Videos: prefer mp4 (H.264, e.g. `ffmpeg -pix_fmt yuv420p`). Images: png/jpg/gif/webp/avif. Max 100MB per file.
- Raw bytes serve from R2, never proxied through Vercel (saves bandwidth).
- Short redirect: `$SLOP_MEDIA_URL/v/<id>` → raw file.
- Auth: API (upload/list/delete) needs `SLOP_MEDIA_TOKEN` (Bearer). The home grid needs `?key=<GRID_KEY>` — ask the owner for both, they are siblings of the app's `UPLOAD_TOKEN`/`GRID_KEY` env. `/w/<id>` share-links stay public by design (safe to paste anywhere).
- Never print or commit tokens / R2 keys. They live in Vercel env + `web/.env` (gitignored).
