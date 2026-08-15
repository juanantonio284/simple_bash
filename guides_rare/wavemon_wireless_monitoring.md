# wavemon

[wavemon][git_wavemon] is a wireless device monitoring application that allows you to watch signal
and noise levels, packet statistics, device configuration and network parameters of your wireless
network hardware. It should work (though with varying features) with all devices supported by the
Linux kernel.

Both the manual (`man wavemon`) and [this post][benji377] are a bit unclear (sloppy writing); they 
talk about things in a different order, and with different names, than they appear on 
screen[^my_screen]. But I've borrowed heavily from both; the manual has that official quality and 
the post has that human quality with comments which, if correct, help put in context what the 
metrics mean.

[^my_screen]: At least on my screen with wavemon version 0.9.1 on Ubuntu ...

Install with `sudo apt install wavemon`.

<!-- ## Understanding the wavemon interface -->
The wavemon interface splits into different "screens". Each screen presents information in a
specific manner. For example, the `info` screen shows current levels as bargraphs, whereas the
`level` screen represents the same levels as a moving histogram.

On startup, you'll see (depending on configuration) one of the different monitor screens. At the
bottom, you'll find a menu-bar listing the screens and their activating keys. Each screen is
activated by either the corresponding function key or the key corresponding to the first character
of the screen name.

<!-- ≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈≈ -->
## info (name of screen, lowercase)

The `info` screen (lowercase) is the first one you see when you open the program and it is split
into the following sections (from the top down): `Interface`, `Levels`, `Statistics`, `Info`
(uppercase), and `Network`. The `Levels` section shows a moving bar for `link quality` and one for
`signal level`.

### Interface

The `Interface` section at the top shows information about the monitoring interface, including
interface name, type, ESSID, and available encryption formats.

### Levels

You can see up to four bargraphs showing 

* (1) relative signal quality (it says `link quality` on the screen)
* (2) signal level in dBm 
* (3) noise level in dBm and (4) Signal-Noise-Ratio (SNR) if the wireless driver also supports noise
  level information
   
1. `link quality`: If this drops below 40%, you are likely experiencing interference from neighbors
or microwaves.

2. `signal level`: The numbers are negative. The closer to 0, the better.

    * -`30` to `-50` dBm: Excellent
    * -`50` to `-67` dBm: Good. Still useful for streaming and gaming.
    * -`67` to `-70` dBm: Okay. Web browsing is fine, but you might notice lag in video calls.
    * -`80` or lower: Bad. Frequent disconnects and packet loss.

### Statistics

1. `RX`: The speed at which your computer can receive data from the router.

2. `TX`: The speed at which your computer can transmit data to the router.

3. `retries`: A low number is good; a high number (rapidly increasing) means your WiFi card is
shouting data at the router but the router isn't hearing it, so it has to shout again. This usually
happens in crowded WiFi areas (apartment buildings) or when you are too far away.

Note that `RX` and `TX` are "link speeds", not internet speed. 
If, for example, your `rx rate`[^note_Info_section] is 780 Mbit/s your local file transfers 
(like moving files to network attached storage) will be fast although your internet might still 
be slow (depending on what you get from your ISP).

[^note_Info_section]: `rx rate` is seen on the `Info` (uppercase) section


## Other stuff

Note: some operations, such as displaying encryption information or performing scans, require
CAP_NET_ADMIN privileges (see capabilities(7)). For non-root users, these can be enabled by
installing `wavemon setuid-root`. Running `sudo wavemon` might also work.




[benji377]: https://dev.to/benji377/visualize-your-wifi-stability-in-the-linux-terminal-with-wavemon-44hi

[git_wavemon]: https://github.com/uoaerg/wavemon


<!-- Suggestions: -->

<!-- F2 (Level Histogram): Press F2 to see a moving graph of your signal. Walk around your house with your laptop open to this screen. You can literally see the signal drop when you walk behind a thick concrete wall or a refrigerator. -->

<!-- F3 (Scan): Shows all other WiFi networks nearby. Great for seeing if your neighbors are clogging up your specific WiFi channel. -->
