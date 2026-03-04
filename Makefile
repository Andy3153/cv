## vim: set fenc=utf-8 ts=4 sw=0 sts=0 sr et si tw=0 fdm=marker fmr={{{,}}}:
##
## Makefile
##

# {{{ Variables
cmd  = latexmk
args = -lualatex -shell-escape -file-line-error -interaction=nonstopmode -use-make cv

date = $(shell date +%Y%m%d)

compilecmd   = $(cmd) $(args)

softcleancmd = $(cmd) -c
cleancmd     = $(cmd) -C

rmsoftcleancmd = rm *.aux *.fdb_latexmk *.fls *.latexrun.db *.latexrun.db.lock *.log *.out *.pyg *.synctex.gz *.toc *.xdv
rmcleancmd     = $(softcleancmd) *.pdf
# }}}

# {{{ Targets
.PHONY: all cv noemail nophone nophoto noemail-nophone noemail-nophoto nophone-nophoto noemail-nophone-nophoto release clean softclean

all: cv softclean

# {{{ Catch-all
%.pdf: cv.tex
	$(compilecmd) -jobname="$(basename $@)"
# }}}

# {{{ LaTeX jobs from document
cv: cv.pdf
noemail: cv-noemail.pdf
nophone: cv-nophone.pdf
nophoto: cv-nophoto.pdf
noemail-nophone: cv-noemail-nophone.pdf
noemail-nophoto: cv-noemail-nophoto.pdf
nophone-nophoto: cv-nophone-nophoto.pdf
noemail-nophone-nophoto: cv-noemail-nophone-nophoto.pdf
# }}}

# {{{ Releases
release-nophone: cv.tex
	$(compilecmd) -jobname="cv-nophone-release" && rm cv.nophone.$(date).tex.pdf || true && mv cv-nophone-release.pdf cv.nophone.$(date).tex.pdf
release-noemail-nophone: cv.tex
	$(compilecmd) -jobname="cv-noemail-nophone-release" && rm cv.noemail-nophone.$(date).tex.pdf || true && mv cv-noemail-nophone-release.pdf cv.noemail-nophone.$(date).tex.pdf
release-noemail-nophone-nophoto: cv.tex
	$(compilecmd) -jobname="cv-noemail-nophone-nophoto-release" && rm cv.noemail-nophone-nophoto.$(date).tex.pdf || true && mv cv-noemail-nophone-nophoto-release.pdf cv.noemail-nophone-nophoto.$(date).tex.pdf

release-git: cv.tex
	$(compilecmd) -jobname="cv-noemail-nophone-release" && rm cv.tex.pdf || true && mv cv-noemail-nophone-release.pdf cv.tex.pdf
release-linkedin: cv.tex
	$(compilecmd) -jobname="cv-release" && rm cv.linkedin.$(date).tex.pdf || true && mv cv-release.pdf cv.linkedin.$(date).tex.pdf
release-other: cv.tex
	$(compilecmd) -jobname="cv-release" && rm cv.release.$(date).tex.pdf || true && mv cv-release.pdf cv.release.$(date).tex.pdf
# }}}

# {{{ Cleaners
clean:
	$(cleancmd)

softclean:
	$(softcleancmd)

rmclean:
	$(rmcleancmd)

rmsoftclean:
	$(rmsoftcleancmd)
# }}}
# }}}
