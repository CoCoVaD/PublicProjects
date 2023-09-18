DOT=/usr/local/bin/dot
SFDP=/usr/local/bin/sfdp
PROBCLI=probcli

prob_latex_doc.pdf: prob_latex_doc.tex figures/ab.pdf
	pdflatex prob_latex_doc.tex
prob_latex_doc.tex figures/ab.dot: prob_latex_doc_raw.tex ProBLatex.mch
	time $(PROBCLI) ProBLatex.mch -latex prob_latex_doc_raw.tex prob_latex_doc.tex -p path_to_dot $(DOT) -init -animate 5

figures/ab.pdf: figures/ab.dot
	$(SFDP) -Tpdf figures/ab.dot > figures/ab.pdf


clean:
	rm *.pdf
	rm prob_latex_doc.tex scheduler.tex
	rm figures/*.pdf
