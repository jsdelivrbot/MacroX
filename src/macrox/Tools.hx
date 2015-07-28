//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package macrox;
#if macro
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools as HxTypeTools;
import haxe.macro.Context;
import macrox.AType;
import macrox.AMetadata;
using Lambda;

/**
 * Collection of tools to deal with types and exprs in macro.
 * ```haxe
 * using macrox.Tools;
 * ```
 * ####Includes
 *
 * - `TypeTools`
 * - `ClassTypeTools`
 * - `ExprTools`
 * - `FieldTools`
 * - `TypeParamTools`
 */
@:dox(show) typedef Tools={};
@:dox(hide) typedef TExprTools = haxe.macro.ExprTools;
@:dox(hide) typedef TComplexTypeTools = haxe.macro.ComplexTypeTools;
@:dox(hide) typedef TMacroStringTools = haxe.macro.MacroStringTools;
@:dox(hide) typedef TTypedExprTools = haxe.macro.TypedExprTools;
@:dox(hide) typedef TPositionTools = haxe.macro.PositionTools;
//[`haxe.macro.Type`](http://api.haxe.org/haxe/macro/Type.html)
/**
 * Tools to deal with `AType`
 * ```haxe
 * using macrox.Tools;
 * ```
 */
class TypeTools {
	#if macro
    /** Cast this to `AType` */
    static public inline function aType(t:AType):AType return t;
    /** @see [`haxe.macro.TypeTools.follow`](http://api.haxe.org/haxe/macro/TypeTools.html#follow)*/
    static public inline function follow(t:AType, ?once : Bool ) : AType return Context.follow(t, once);
    /** @see [`haxe.macro.TypeTools.unify`](http://api.haxe.org/haxe/macro/TypeTools.html#unify)*/
    static public inline function unify(t1:AType, t2:AType):Bool return Context.unify(t1, t2);
	/** Get a `Null<T>` of this type */
    static public inline function nullable(t : AType) : AType return macro : Null<$t>;
	/** Check if this type is `Null<T>` */
    static public inline function isNullable(t : AType) : Bool return t.toType().match(TType(_.get().name => "Null", _));
    /** @see [`haxe.macro.TypeTools.getClass`](http://api.haxe.org/haxe/macro/TypeTools.html#getClass)*/
    static public inline function getClass(t : AType) : ClassType return HxTypeTools.getClass(t);
    /** @see [`haxe.macro.TypeTools.getEnum`](http://api.haxe.org/haxe/macro/TypeTools.html#getEnum)*/
	static public inline function getEnum(t : AType) : EnumType return HxTypeTools.getEnum(t);
    /** @see [`haxe.macro.TypeTools.map`](http://api.haxe.org/haxe/macro/TypeTools.html#map)*/
	static public inline function map(t:AType, f:Type -> Type) : AType return HxTypeTools.map(t, f);
    /** Get the [`haxe.macro.TypePath`](http://api.haxe.org/haxe/macro/TypePath.html)*/
	static public inline function getTypePath(t:AType):TypePath {
		return switch(t.toComplexType()) {
			case TPath(p): p;
			case _: null;
		}
	}
    /** @see [`haxe.macro.TypeTools.findField`](http://api.haxe.org/haxe/macro/TypeTools.html#findField)*/
	static public inline function findField(t:AType,name:String, isStatic:Bool = false):Null<ClassField> 
        return HxTypeTools.findField(t, name, isStatic);

    static public function hasInterface(t:AType,i:AType){
    	if (t==null && i==null) return false;
		switch(follow(t)) {
			case TInst(c, _): 
				var ct=c.get();
				for (c in ct.interfaces) {
					if (unify(c.t.get(),i))
						return true;
					if (ct.superClass != null) 
					if (hasInterface(ct.superClass.t.get(),i))
						return true;
				}
			case _: return false;
		}
    	return false;
    }
	#end
}
/**
 * Tools to deal with [`haxe.macro.ClassType`](http://api.haxe.org/haxe/macro/ClassType.html)
 * ```haxe
 * using macrox.Tools;
 * ```
 */
class ClassTypeTools {
	#if macro
    /** Cast this to `AType` */
	public static inline function aType(ct:ClassType):AType
		return TPath( { pack:ct.pack, name:ct.name } );
    /**
	 * Get `AMetadata` from this classType
     */
	public static inline function metas(bt:BaseType) return (bt : AMetadata);
	/**
     * Returns true if ct and t unify, false otherwise.
     */
	public static inline function unify(ct:ClassType,t:AType):Bool
		return TypeTools.unify(aType(ct),t);
    /** Returns true if this type have the specified interface */
	public static function hasInterface(ct:ClassType, intf:String) :Bool{
        //TODO Dont use this function should check against `AType`
		for (i in ct.interfaces) 
			if (i.t.toString() == intf)
				return true;
		if (ct.superClass != null) 
			if (hasInterface(ct.superClass.t.get(),intf))
				return true;
		return false;
	}
	public static function toString(ct:ClassType):String{
		return ct.pack.concat([ct.name]).join('.');
	}
	#end
}
/**
 * Tools to deal with [`haxe.macro.Expr`](http://api.haxe.org/haxe/macro/Expr.html)
 * ```haxe
 * using macrox.Tools;
 * ```
 */
class ExprTools {
    /** Get the type (`AType`) of this `Expr` */
	public static inline function aType(e:Expr) : AType	
		return Context.typeof(e);
	/** Check if this `Expr` type unifies with the specified type */
	public static inline function typeUnify(e:Expr, type:AType):Bool 
		return Context.unify(Context.typeof(e), type);
	/** Returns this `Expr` at a diferent `Position` */
	public static inline function at(expr:ExprDef, pos:Position):Expr
		return { expr:expr, pos:pos };
    /** @see [`haxe.macro.Context.typeExpr`](http://api.haxe.org/haxe/macro/Context.html#typeExpr) */
	public static inline function typeExpr(e:Expr) : haxe.macro.Type.TypedExpr	
		return Context.typeExpr(e);	
    /** Return true if this `Expr` is `null` or has the value `null` */
    public static inline function isNull(e:Expr):Bool
        return e == null || e.expr.match(EConst(CIdent("null")));
    
}
/**
 * Tools to deal with [`haxe.macro.Field`](http://api.haxe.org/haxe/macro/Field.html)
 * ```haxe
 * using macrox.Tools;
 * ```
 */
class FieldTools {
//    /** Get the type (`AType`) of this `Field` */
//    public static inline function aType(tp:Field) : AType
//        return switch (tp) {
//            case FVar(t,_) | FProp(_,_,t,_): t;
//            case FFun(f): f.ret;
//        };
    /** Typed utility tool to get the metas of this `Field` */
	public static inline function metas(f:Field) return (f : AMetadata);
}
/**
 * Tools to deal with [`haxe.macro.TypeParam`](http://api.haxe.org/haxe/macro/TypeParam.html)
 * ```haxe
 * using macrox.Tools;
 * ```
 */
class TypeParamTools {
    /** Get the type (`AType`) of this `TypeParam` */
	public static inline function aType(tp:TypeParam) : AType
	    return switch (tp) { case TPType(t): t; case TPExpr(e): ExprTools.aType(e); };
}
#end