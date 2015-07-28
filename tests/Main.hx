package;

/**
 * ...
 * @author Porfirio
 */
class Main{
    static function main() {
		test();
	}
	macro static function test() {
        var r = new haxe.unit.TestRunner();
        r.add(new TestMeta());
        r.add(new TestDefines());
        r.add(new TestType());
        r.add(new TestHxon());
        r.run();
        return macro trace("It works");
	}
	
}