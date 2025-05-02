# USING yt-dlp

## Installation

```Bash
sudo apt update
curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o ~/.local/bin/yt-dlp
chmod a+rx ~/.local/bin/yt-dlp  # Make executable
yt-dlp -U
yt-dlp --help
```

## Downloading Video

### Step 1 

```Bash

cd /path/to/directory
yt-dlp -F --list-formats https://youtu.be/QrgV35cBHVs?si=yIV_mkPcJrMJtiUP
# In the output below you can see that 616 is the best video and 234 is the best(?) audio. 

# [youtube] QrgV35cBHVs: Downloading m3u8 information
# [info] Available formats for QrgV35cBHVs:
# ID  EXT   RESOLUTION FPS │   FILESIZE   TBR PROTO │ VCODEC          VBR ACODEC     MORE INFO
# ─────────────────────────────────────────────────────────────────────────────────────────────
# sb3 mhtml 48x27        0 │                  mhtml │ images                         storyboard
# sb2 mhtml 80x45        0 │                  mhtml │ images                         storyboard
# sb1 mhtml 160x90       0 │                  mhtml │ images                         storyboard
# sb0 mhtml 320x180      0 │                  mhtml │ images                         storyboard
# 233 mp4   audio only     │                  m3u8  │ audio only          unknown    Default
# 234 mp4   audio only     │                  m3u8  │ audio only          unknown    Default
# 602 mp4   256x144     15 │ ~ 66.29MiB  112k m3u8  │ vp09.00.10.08  112k video only
# 269 mp4   256x144     30 │ ~103.15MiB  175k m3u8  │ avc1.4D400C    175k video only
# 603 mp4   256x144     30 │ ~105.05MiB  178k m3u8  │ vp09.00.11.08  178k video only
# 229 mp4   426x240     30 │ ~186.56MiB  316k m3u8  │ avc1.4D4015    316k video only
# 604 mp4   426x240     30 │ ~181.60MiB  308k m3u8  │ vp09.00.20.08  308k video only
# 230 mp4   640x360     30 │ ~476.58MiB  807k m3u8  │ avc1.4D401E    807k video only
# 605 mp4   640x360     30 │ ~444.91MiB  754k m3u8  │ vp09.00.21.08  754k video only
# 231 mp4   854x480     30 │ ~803.88MiB 1362k m3u8  │ avc1.4D401F   1362k video only
# 606 mp4   854x480     30 │ ~694.32MiB 1176k m3u8  │ vp09.00.30.08 1176k video only
# 232 mp4   1280x720    30 │ ~  1.48GiB 2571k m3u8  │ avc1.4D401F   2571k video only
# 609 mp4   1280x720    30 │ ~  1.27GiB 2197k m3u8  │ vp09.00.31.08 2197k video only
# 270 mp4   1920x1080   30 │ ~  3.09GiB 5354k m3u8  │ avc1.640028   5354k video only
# 614 mp4   1920x1080   30 │ ~  2.07GiB 3594k m3u8  │ vp09.00.40.08 3594k video only
# 616 mp4   1920x1080   30 │ ~  3.34GiB 5801k m3u8  │ vp09.00.40.08 5801k video only Premium

```

# Test (same as above with "console" syntax in the markdown box, i.e. the code listing)

```console

$ cd /path/to/directory
$ yt-dlp -F --list-formats https://youtu.be/QrgV35cBHVs?si=yIV_mkPcJrMJtiUP

In the output below you can see that 616 is the best video and 234 is the best(?) audio. 

[youtube] QrgV35cBHVs: Downloading m3u8 information
[info] Available formats for QrgV35cBHVs:
ID  EXT   RESOLUTION FPS │   FILESIZE   TBR PROTO │ VCODEC          VBR ACODEC     MORE INFO
─────────────────────────────────────────────────────────────────────────────────────────────
sb3 mhtml 48x27        0 │                  mhtml │ images                         storyboard
sb2 mhtml 80x45        0 │                  mhtml │ images                         storyboard
sb1 mhtml 160x90       0 │                  mhtml │ images                         storyboard
sb0 mhtml 320x180      0 │                  mhtml │ images                         storyboard
233 mp4   audio only     │                  m3u8  │ audio only          unknown    Default
234 mp4   audio only     │                  m3u8  │ audio only          unknown    Default
602 mp4   256x144     15 │ ~ 66.29MiB  112k m3u8  │ vp09.00.10.08  112k video only
269 mp4   256x144     30 │ ~103.15MiB  175k m3u8  │ avc1.4D400C    175k video only
603 mp4   256x144     30 │ ~105.05MiB  178k m3u8  │ vp09.00.11.08  178k video only
229 mp4   426x240     30 │ ~186.56MiB  316k m3u8  │ avc1.4D4015    316k video only
604 mp4   426x240     30 │ ~181.60MiB  308k m3u8  │ vp09.00.20.08  308k video only
230 mp4   640x360     30 │ ~476.58MiB  807k m3u8  │ avc1.4D401E    807k video only
605 mp4   640x360     30 │ ~444.91MiB  754k m3u8  │ vp09.00.21.08  754k video only
231 mp4   854x480     30 │ ~803.88MiB 1362k m3u8  │ avc1.4D401F   1362k video only
606 mp4   854x480     30 │ ~694.32MiB 1176k m3u8  │ vp09.00.30.08 1176k video only
232 mp4   1280x720    30 │ ~  1.48GiB 2571k m3u8  │ avc1.4D401F   2571k video only
609 mp4   1280x720    30 │ ~  1.27GiB 2197k m3u8  │ vp09.00.31.08 2197k video only
270 mp4   1920x1080   30 │ ~  3.09GiB 5354k m3u8  │ avc1.640028   5354k video only
614 mp4   1920x1080   30 │ ~  2.07GiB 3594k m3u8  │ vp09.00.40.08 3594k video only
616 mp4   1920x1080   30 │ ~  3.34GiB 5801k m3u8  │ vp09.00.40.08 5801k video only Premium

```
