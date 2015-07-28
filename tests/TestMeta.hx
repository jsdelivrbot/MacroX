package;

import haxe.unit.TestCase;

#if macro
import haxe.macro.Context;
import macrox.AType;
import macrox.AMetadata;
import macrox.Metas;
import macrox.HxMetas;

using macrox.Tools;

@:enum @:forward
abstract MyMetas(Metas) to Metas {
	var A = ":A";
	var B = ":B";
}
#end
typedef MetaV = {
	a:String
}

@:A("foo","bar")
@:A("foo")
@:A(["foo","bar"])
@:A([1,2,3])
@:A({a:"foo"})
@:A(465)
#if !macro @:build(TestMeta.build()) #end
class TestMeta extends TestCase{
    @:B
    static var field:String;
	public function new() {
		super();
		
	}
	#if macro
    static var at:AType=(macro : TestMeta);
    static var md:AMetadata=at;
    public function testBasic(){
        assertTrue(MyMetas.A.existsOn(md));
        assertTrue(md.has(":A"));
        assertFalse(MyMetas.B.existsOn(md));
        assertTrue(HxMetas.Keep.existsOn(md));
    }

    function testExtract(){
        var v={pair:{a:null,b:null},string:null,aString:null,aInt:null,metaV:null}
        MyMetas.A.extractFrom(md,
            function(a:String,b:String) v.pair={a:a,b:b},
            function(s:String) v.string=s,
            function(a:Array<String>) v.aString=a,
            function(a:Array<Int>) v.aInt=a,
            function(m:TestMeta.MetaV) v.metaV=m
        );

        assertEquals("foo",v.pair.a);
        assertEquals("bar",v.pair.b);
        assertEquals("foo",v.string);
        assertEquals("foo",v.aString[0]);
        assertEquals("bar",v.aString[1]);
        assertEquals("123",v.aInt.join(''));
        assertEquals("foo",v.metaV.a);
    }
    function testField(){
        var f=at.findField("field",true);
        assertTrue(MyMetas.B.existsOn(f));
    }
	#end

	#if macro
	static function build() {
		var fields = Context.getBuildFields();
		var k:AMetadata = Context.getLocalClass();

        HxMetas.Keep.addTo(k);
		return fields;
	}
	#end
}