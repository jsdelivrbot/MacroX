package;

import haxe.unit.TestCase;
import macrox.HxDefines;

class TestDefines extends TestCase{

	public function new() super();
	
	function testDefined() {
        assertTrue(HxDefines.get("test").defined());
        assertTrue(HxDefines.NoMacroCache.defined());
	}

    function testValue() {
        assertEquals(HxDefines.get("define").value(),"value");
        assertEquals(HxDefines.Dce.value(),"std");
    }
}