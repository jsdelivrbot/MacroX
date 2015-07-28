package ;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.unit.TestCase;
import macrox.AType;
using macrox.Tools;

class TestType extends TestCase{

	public function new() super();

	
	function testCastComplex() {
        var t1=macro : Main;
        var t2=AType.get("Main");
        var e1=macro {var x:$t1;x;};
        var e2=macro {var x:$t2;x;};
        assertTrue((t1 is ComplexType));
        assertTrue((t2 is Type));
        assertTrue(t1.unify(t2));
        assertTrue(t2.unify(t1));
        assertTrue(e1.typeUnify(t1));
        assertTrue(e2.typeUnify(t1));
        assertTrue(e1.typeUnify(t2));
        assertTrue(e2.typeUnify(t2));
    }

    function testNull(){
        assertTrue(AType.get("Main").nullable().isNullable());
    }

    function testCastToString() {
        assertEquals("Main",(macro : Main).aType());
        assertEquals("Main",(macro {var x:Main;x;}).aType());
    }

    function testGet() assertTrue(AType.get("Main").unify(macro : Main));
}