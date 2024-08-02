# Common Tasks With PDF files Using Ghostscript 

[Ghostscript][] is an interpreter for the PostScript®  language and PDF files ... It has been under
active development for over 30 years and has been ported to several different systems during this
time.

## 1. Combine various PDF files into one single file

```Bash

# COMBINE VARIOUS PDF FILES (preferred code using -o shortcut)
gs -sDEVICE=pdfwrite \
   -o combined_file.pdf \
   1.pdf \
   2.pdf \
   3.pdf 
# inputs can also be PostScript or EPS and can be mixed
   
```

**Another option (just for reference)**

```Bash

# COMBINE VARIOUS PDF FILES 
# same as above but using normal syntax and including the -dSAFER option, which might not be
# necessary in newer versions of gs
gs -sDEVICE=pdfwrite \
   -dNOPAUSE -dBATCH -dSAFER \
   -sOutputFile=combined_file.pdf \
   1.pdf \
   2.pdf \
   3.pdf
# -dNOPAUSE and -dBATCH disable the interactive prompting

```

### Explanation

#### `-sDEVICE=device`

`-sDEVICE=device` selects an alternate initial output device.

Ghostscript has a notion of 'output devices' which handle saving or displaying the results in a
particular format. Ghostscript comes with a diverse variety of such devices supporting vector and
raster file output, screen display, driving various printers and communicating with other
applications.

The command line option '`-sDEVICE=device`' selects which output device Ghostscript should use. If
this option isn't given, the default device is used (usually a display device). To send the output
to a file, use the -`sOutputFile= switch` or the abbreviated `-o` (see below). 

**`-o` option**

As a convenient shorthand you can use the `-o` option followed by the output file specification as
discussed above. This is intended to be a quick way to invoke ghostscript to convert one or more
input files. The `-o` option also sets the `-dBATCH` and `-dNOPAUSE` options. (The `-dBATCH`
`-dNOPAUSE` options in the examples above disable the interactive prompting. The interpreter also
quits gracefully if it encounters end-of-file or control-C.)

`-o` is equivalent to `-sOutputFile=file_name -dBATCH -dNOPAUSE <input_file (or files)>`

For instance, to convert `somefile.ps` to JPEG image files, one per page, use:  
`gs -sDEVICE=jpeg -o out-%d.jpg somefile.ps`

This is equivalent to:  
`gs -sDEVICE=jpeg -sOutputFile=out-%d.jpg -dBATCH -dNOPAUSE somefile.ps `

(See more in the [documentation][link_1])




[Ghostscript]: https://www.ghostscript.com/
[link_1]: https://ghostscript.com/docs/9.54.0/Use.htm
