## vim: set fenc=utf-8 ts=4 sw=0 sts=0 sr et si tw=0 fdm=marker fmr={{{,}}}:
##
## Latexmk configuration
##

# {{{ Decrease PDF file size
END
{
    my $pdf= "$root_filename.pdf";
    return unless -e $pdf; # run if file does not exist

    my $cmd = "gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dQUIET -dNOPAUSE -dBATCH -dPDFSETTINGS=/prepress -dDetectDuplicateImages -dCompressFonts=true -sOutputFile=$pdf.compressed $pdf";

    warn "[latexmkrc:compress] Compressing PDF: $cmd\n";
    system($cmd) == 0 or warn "[latexmkrc:compress] Compression failed!\n";
    system("mv $pdf.compressed $pdf")
}
# }}}
