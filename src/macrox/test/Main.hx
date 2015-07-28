package macrox.test;

import haxe.extern.EitherType;
import haxe.macro.Compiler;
import macrox.HxDefines;

#if macro
	import haxe.macro.Expr;
	import haxe.macro.Context;
	
	import macrox.Metas;
	using macrox.Tools;


	@:enum @:forward
	abstract MyMeta(Metas) to Metas {
		/**
		 * Test metadata can be either a String or a TestDef
		 */
		var test = ":test";
	}
	typedef TestDef = {
		name:String,
		?works:Bool
	}
	typedef TestT = EitherType<String,TestDef>;
#end

#if !macro @:build(macrox.test.Main.build()) #end
@:test("foo")
class Main{

	@:test("a","b")
	@:test("c",{name:"d"})
	static function main() {

	}
	
	#if macro
	static function build():Array<Field> {
		var fields = Context.getBuildFields();
		
		//trace("-D test",HxDefines.get("test").defined());
		//if (HxDefines.Dce)
			//trace(HxDefines.Dce.value());
		//var k = Context.getLocalClass();
		
		//for (f in fields) {
			//if (MyMeta.test.existsOn(f)) {			
				//MyMeta.test.each(f,  function(v:TestT) { if (Std.is(v, String)) trace(v) else trace((v:TestDef).name); } );
			//}
		//}
		return fields;
	}
	#end
}