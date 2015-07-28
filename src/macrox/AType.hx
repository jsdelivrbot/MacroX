//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package macrox;
#if (macro || display)
import haxe.macro.Context;
import haxe.extern.EitherType;
import haxe.macro.ComplexTypeTools;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.TypeTools as HxTypeTools;
import macrox.Tools;


//private typedef TEType = EitherType<Type,ComplexType>;

/**
 * Abstract type to either Type or ComplexType.
 *
 * @see [`haxe.macro.Type`](http://api.haxe.org/haxe/macro/Type.html)
 * @see [`haxe.macro.ComplexType`](http://api.haxe.org/haxe/macro/ComplexType.html)
 * @see `TypeTools` for more utility function
 */
abstract AType(EitherType<Type,ComplexType>) from EitherType<Type,ComplexType> {
    /** @see [`haxe.macro.Context.getType`](http://api.haxe.org/haxe/macro/Context.html#getType)*/
    @:from public static function get(name:String)
        return cast Context.getType(name);
    @:from public static function fromClassType(ct:ClassType)
        return cast TPath( { pack:ct.pack, name:ct.name } );
    
    /** @see [`haxe.macro.ComplexTypeTools.toType`](http://api.haxe.org/haxe/macro/ComplexTypeTools.html#toType)*/
    @:to public inline function toType():Type 
        return if (Std.is(this, Type)) this; else ComplexTypeTools.toType(this);
    /** @see [`haxe.macro.TypeTools.toComplexType`](http://api.haxe.org/haxe/macro/TypeTools.html#toComplexType)*/
    @:to public inline function toComplexType():ComplexType 
        return if (Std.is(this, ComplexType)) this; else HxTypeTools.toComplexType(this);
    /**
     * @see [`haxe.macro.TypeTools.toString`](http://api.haxe.org/haxe/macro/TypeTools.html#toString)
     * @see [`haxe.macro.ComplexTypeTools.toString`](http://api.haxe.org/haxe/macro/ComplexTypeTools.html#toString)
     */
    @:to public inline function toString():String
        return if (Std.is(this, Type)) HxTypeTools.toString(this) else if (Std.is(this, ComplexType)) ComplexTypeTools.toString(this) else "null";
    /** @see [`haxe.macro.TypeTools.getClass`](http://api.haxe.org/haxe/macro/TypeTools.html#getClass)*/
    @:to public inline function getClass() : ClassType return TypeTools.getClass(this);
    /** @see [`haxe.macro.TypeTools.getEnum`](http://api.haxe.org/haxe/macro/TypeTools.html#getEnum)*/
	@:to public inline function getEnum() : EnumType return TypeTools.getEnum(this);
    /** @see [`haxe.macro.TypeTools.map`](http://api.haxe.org/haxe/macro/TypeTools.html#map)*/
    /** @see `TypeTools.getTypePath`*/
    @:to public inline function getTypePath() : TypePath return TypeTools.getTypePath(this);
//	public inline function map(f:Type -> Type) : AType  return TypeTools.map(this, f);
//	/** @see [`haxe.macro.TypeTools.follow`](http://api.haxe.org/haxe/macro/TypeTools.html#follow)*/
//    public inline function follow( ?once : Bool ) : AType return TypeTools.follow(this, once);
//    /** @see [`haxe.macro.TypeTools.unify`](http://api.haxe.org/haxe/macro/TypeTools.html#unify)*/
//    public inline function unify( t:AType ) : Bool return TypeTools.unify(this, t);
//    /** @see `TypeTools.nullable`*/
//    public inline function nullable() : AType return TypeTools.nullable(this);
//    /** @see `TypeTools.isNullable`*/
//    public inline function isNullable() : Bool return TypeTools.isNullable(this);
//    /** @see [`haxe.macro.TypeTools.findField`](http://api.haxe.org/haxe/macro/TypeTools.html#findField)*/
//	public inline function findField(name:String, isStatic:Bool = false):Null<ClassField> return TypeTools.findField(this, name, isStatic);
}
#end
