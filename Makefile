c_printClosure.o : c_printClosure.c
	${GHC} -c $< -o $@ -g3 -optc-3

cmm_printClosure.o : cmm_printClosure.cmm
	${GHC} -c $< -o $@

Main.o : Main.hs
	${GHC} -c $< -o $@

Main : Main.o cmm_printClosure.o c_printClosure.o
	${GHC} $+ -g3 -debug -o $@
