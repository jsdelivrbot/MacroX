//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package macrox;
#if (macro || display)
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;
using macrox.Tools;

/**
 * Hxon is a object notation like JSON but it can be validated to a typedef
 *
 * It also shows errors when missing fields and warning when theres extra fields.
 *
 * TODO not completed yet
 */
class Hxon
{
	#if macro
    public static function parseFile(path:String, t:AType = null):Dynamic {
        var content = sys.io.File.getContent(path);
        var pos = Context.makePosition( { min: 0, max: 0, file: path } );
        var e = Context.parseInlineString(content, pos);
        if (t == null)
            return e.getValue();

        return _extract(e, t);
    }
	#end

    public static function pp<T>(path:String,r:T):T{
        trace(path);
        return null;
    }
	/**
	 * Parse a file
     */
	public static macro function parse(path:String) {
//		trace("hxon"+ Context.getExpectedType());
		var v = parseFile(path, Context.getExpectedType());
		return macro $v{v};
	}

    static function objectGetfields(e:Expr):Map<String,Expr> {
        return switch (e.expr) {
            case EObjectDecl(fields): [for (f in fields) f.field=>f.expr];
            case _: new Map();
        }
    }



    static function _extract(e:Expr, t:AType, name:String = "__root__") :Dynamic {
		// #if macro
        //if (!e.isNull() && e.typeUnify(t)) {
            ////Context.warning('name unifies: $name',e.pos);
            //return e.getValue();
        //}
        //Context.warning('name dont unifies: $name',e.pos);
        var tt = t.follow();
        switch (tt) {
            case TAnonymous(a):
                //if (e.typeUnify(t)) return e.getValue();
                var fields = objectGetfields(e);
                var r = {};
                for (t in a.get().fields) {
                    var ne = fields.get(t.name);
                    if (fields.remove(t.name)) //ne!=null
                        Reflect.setField(r, t.name, _extract(ne, t.type, t.name));
                    else if (!t.type.isNullable())
                        Context.error('Missing property "${t.name}" on object "$name"', e.pos);
                }
                if (!Lambda.empty(fields))
                    for (k in fields.keys())
                        Context.warning('Unused property "$k" on object "$name"', fields.get(k).pos);
                return r;
            case TAbstract(at, _) if (at.get().type.unify(macro : Bool))://Special Bool case
                if (e.typeUnify(t)) return e.getValue();
                return switch(e.expr) {
                    case EConst(CString(_.toLowerCase()=>"true")): true;
                    case EConst(CString(_.toLowerCase()=>"false")): false;
                    case EConst(CInt(n) | CFloat(n)): Std.parseFloat(n) > 0;
                    case _: Context.error('Type mismatch on property "$name", expected true or false', e.pos);
                }
            //TODO Maybe i'm adding too mutch complexity
            case TInst(_.get().name => "String", _): //Allow "str", 'str', 0, 0.0, null
                if (e.typeUnify(t)) return e.getValue();
                return switch (e.expr) {
                    case EConst(CInt(_) | CFloat(_)): e.toString();
                    case EConst(CIdent("null")): if (t.isNullable()) null else Context.error('Property "$name" can not be "null"', e.pos);
                    case _: Context.error('Type mismatch on property "$name", expected String', e.pos);
                }
            case _:
                if (!e.isNull() && e.typeUnify(t))
                    return e.getValue();
                Context.error('Type mismatch on property "$name", expected type: '+tt.toString(), e.pos);
        }
		// #end
        return null;
    }

}
#end