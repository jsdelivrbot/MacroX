package;
//import haxe.macro.Compiler;
import haxe.macro.Type;
import haxe.macro.Context;
import macrox.AType;

#if !macro @:autoBuild(MainTest.buildITest()) #end
interface ITest<T> {
	public function getAll():Array<T>;
}

#if macro
class Test<T> implements ITest<T> {
	public static var A:Test<String>;
	public var name:String;
	public var type:AType;
	public function new(name:String,type:AType){
		this.name = name;
		this.type = type;
	}
	public function getAll():Array<T> {
		trace(name, type);
		return [];
	}
}
#end
#if !macro @:build(MainTest.build()) #end
class MainTest{

	static function main() {}
	#if macro
	static function build() {
		Test.A = new Test<String>(":bla" , macro : String );
		Test.A.getAll();
		return haxe.macro.Context.getBuildFields();
	}
	static function buildITest() {
		var k:ClassType = haxe.macro.Context.getLocalClass().get();
		trace('buildITest', k.name);
		k.meta.add(':genericBuild', [macro MainTest.genericBuild()],k.pos);
		k.meta.add(':generic', [],k.pos);
		return haxe.macro.Context.getBuildFields();
	}
	static function genericBuild() {
		var k = Context.getLocalClass().get();
		var t = Context.getLocalType();
		if (k.isInterface)
			return null;
		//trace('genericBuild',k.isInterface);
		//trace('genericBuild',Context.getLocalTVars());
		return null;
	}
	static function use() {
		////Compiler.addMetadata('@:genericBuild(MainTest.genericBuild())','Test');
		//Compiler.addGlobalMetadata('', '@:genericBuild(MainTest.genericBuild())', true, true, false);
		//Context.onTypeNotFound(function (s:String) {
			////trace(s);
			//return null;
		//});
	}

	#end
}
