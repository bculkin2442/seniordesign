package wvutech.labassist.gen;

import bjc.rgens.parser.RGrammars;

import wvutech.labassist.beans.TermCode;

public class TermCodeGen {
	public static TermCode generateTermCode() {
		return new TermCode(RGrammars.generateExport("[term-code]"));
	}
}
