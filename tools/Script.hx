#!/bin/sh
//bin/false || haxe --run ${0/"./"/""} $@ ; exit;

import sys.io.File;
import sys.io.Process;
import haxe.io.Eof;
using StringTools;

typedef Def = {
	name:String,
	def:String,
	doc:String
}


class Script {

	static var metaEreg:EReg    = ~/^\s*@(:(\w*))\s*:\s(.*)$/;
	static var definesEreg:EReg = ~/^\s*([\w|-]+)\s*:\s*(.*)$/;
	/**
	 * Make the first letter uppercase
	 */
	public static inline function capitalize(string:String)
		return string.charAt(0).toUpperCase() + string.substring(1);

	public static function camelize(string:String){
		var arr=string.split("-");
		for (i in 1...arr.length)
			arr[i]=capitalize(arr[i]);
		return arr.join("");
	}

	public static function main() {
		genHxMetas();
		genHxDefines();
	}

	static function genHxMetas() {
		var cmd = new Process("haxe", ["--help-metas"]);

		var allMetas:Array<Def> = [];

		var index = -1;
		try {
			while( true ) {
				var line = cmd.stdout.readLine();

				var match = metaEreg.match(line);
				//Sys.exit(2);
				if (match) {
					index++;
					//metaEreg.matched(0);
					var def:Def = {
						name:metaEreg.matched(1),
						def:capitalize(metaEreg.matched(2)),
						doc:metaEreg.matched(3)
					}
					allMetas[index]=def;
				}

				else {
					allMetas[index].doc += (' '+ ~/^\s*/.replace(line, ""));
				}

			}
		} catch ( e : Eof ) { }

		writeHx("HxMetas-in.hx", '../src/macrox/HxMetas.hx', allMetas);
        writeMd("HxMetas-in.md", "../docs/HxMetas.md", 'HxMetas', allMetas);
	}

	static function genHxDefines() {
		var cmd = new Process("haxe", ["--help-defines"]);


		var allDefines:Array<Def> = [];

		var index = -1;
		try {
			while( true ) {
				var line = cmd.stdout.readLine();

				if (definesEreg.match(line)) {
					index++;
					var def:Def = {
						name:definesEreg.matched(1),
						def:capitalize(camelize(definesEreg.matched(1))),
						doc:definesEreg.matched(2)
					}
					allDefines[index]=def;
				} else {
					allDefines[index].doc += (' '+ ~/^\s*/.replace(line, ""));
				}

			}
		} catch ( e : Eof ) { }

		writeHx("HxDefines-in.hx", '../src/macrox/HxDefines.hx', allDefines);
		writeMd("HxDefines-in.md", "../docs/HxDefines.md", 'HxDefines', allDefines);
	}

	static function writeHx(inFile:String, outFile:String, defs:Array<Def>) {
		Sys.println('Generaring: $outFile');
		var hxIn = File.getContent(inFile);

		var hxBody = "";
		for (m in defs) {
				hxBody+='\t/**${m.doc} */\n\tvar ${m.def}="${m.name}";\n';
//				hxBody+='\t/**${m.doc} */\n\tpublic static var ${m.def}="${m.name}";\n';
		}
		var hxOut = StringTools.replace(hxIn, "	/*gen-content*/", hxBody);
		File.saveContent(outFile, hxOut);
	}

	static function writeMd(inFile:String, outFile:String, prefix:String, defs:Array<Def>) {
		Sys.println('Generaring: $outFile');
		var mdIn = File.getContent(inFile);
		var mdBody = "";
		for (m in defs) {
			//var doc = StringTools.replace(m.doc, "|", "!");
			mdBody+='`$prefix.${m.def}` | ${m.name} | ${m.doc}\n';
				//mdBody+='```haxe\nvar ${m.def}="${m.name}";\n```\n > ${m.doc}\n\n';
		}
		var mdOut = StringTools.replace(mdIn, "*gen-content*", mdBody);
		File.saveContent(outFile, mdOut);
	}
}