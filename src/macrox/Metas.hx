package macrox;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
using macrox.Tools;

@:dox(hide) //TODO maybe show and add more functions
abstract AllMetaValue(Array<MetadataEntry>) from Array<MetadataEntry> {
	@:noCompletion @:dox(hide)
	public function _each<T>(t:AType, fn:T -> Void) : AllMetaValue {
		for (m in this.copy()) {
			for (p in m.params.copy()) {
				if (t == null || p.typeUnify(t)) {
					fn(p.getValue());
					m.params.remove(p);
					if (m.params.length == 0)
						this.remove(m);
				}
			}
		}
		return this;
	}
    @:noCompletion @:dox(hide)
	public function _eachPair<T1,T2>(t1:AType, t2:AType, fn:T1 -> T2 -> Void): AllMetaValue {
		for (m in this.copy()) {
			if (m.params.length == 2 && m.params[0].typeUnify(t1) && m.params[1].typeUnify(t2)) {
				fn(m.params[0].getValue(), m.params[1].getValue());
				this.remove(m);
			}
		}
        return this;
    }
	
	public function fail() {
		for (m in this) {
			Context.fatalError('Metadata check failed, expected ', m.pos);
		}
	}
}
@:dox(hide) enum EType{
    One(te:Expr);
    Pair(te1:Expr,te2:Expr);
}
@:dox(hide) typedef FNArg={
    ?type:EType,
    metas:AMetadata,
    ?fn:Expr,
}
/**
 * Abstract to be extended for generate abstract enums width metas.
 *
 * ```haxe
 * @:enum @:forward abstract MyMeta(macrox.Metas) from macrox.Metas{
 *      var SomeMeta=":someMeta";
 * }
 * ```
 */
abstract Metas(String) to String from String {
    /**
	 * Get a custom compiler flag like
	 * ```haxe
	 * Metas.get(":test").existsOn(someField);
	 * ```
	 */
    @:from public static inline function get(name:String):Metas return cast name;
	/**
	 * Checks if this meta exists on the specified metadata object.
	 * @see `AMetadata.has`
	 */
	public inline function existsOn(md:AMetadata) return md.has(this);
	/**
	 * Add this meta to the specified metadata object.
	 * @see `AMetadata.add`
	 */
	public inline function addTo(md:AMetadata, params : Array<Expr> = null, pos : Position = null) return md.add(this, params, pos);
	/**
	 * Remove this meta to the specified metadata object.
	 * @see `AMetadata.remove`
	 */
	public inline function removeFrom(md:AMetadata) md.remove(this);
	
//	public inline function all(md:AMetadata):AllMetaValue return md.getAll(this);
	/**
	 * @see `AMetadata.getAll`
	 */
	public inline function getAllFrom(md:AMetadata) return md.getAll(this);
	/**
	 * @see `AMetadata.getAllExpr`
	 */
	public inline function getAllExprFrom(md:AMetadata) return md.getAllExpr(this);
	/**
	 * @see `AMetadata.getAllValue`
	 */
	public inline function getAllValueFrom(md:AMetadata) return md.getAllValue(this);

    static function typeToExpr(type:AType,pos):Expr {
        return switch(type.toType()) {
            case TMono(_) | TDynamic(_):
                macro null;
            case TType(t, _):
                Context.parse('Context.getType("$type")', pos);
            case TInst(_, _) | TAbstract(_,_):
                Context.parse('macro : $type', pos);
            case _:
                Context.error('Unsuported type: $type', pos);
        }
    }

	static function parseFn(e:Expr,?fa:FNArg):FNArg{
        if (fa==null) fa={metas:[]}
        switch (e.expr){
            case EMeta(s,e):
                fa.metas.push(s);
                return parseFn(e,fa);
            case EFunction(name,f):
                switch(f.args.length){
                    case 1:
                        fa.type=EType.One(typeToExpr(f.args[0].type,e.pos));
                    case 2:
                        fa.type=EType.Pair(typeToExpr(f.args[0].type,e.pos),typeToExpr(f.args[1].type,e.pos));
                    case _:
                        Context.error("wrong arguments", e.pos);
                }
                fa.fn=e;
            case _:
        }
		return fa;
	}

	/**
     * Extract this meta from the specified `AMetadata`
     * Typed functions passed will be used to validate and extract data
     *
     */
    public macro function extractFrom(ethis:Expr, md:ExprOf<AMetadata>, allFn:Array<ExprOf<Dynamic -> Void>>){
        var e=macro (($md : macrox.AMetadata).getAll($ethis) : macrox.Metas.AllMetaValue);
        for (fn in allFn){
            var fa=parseFn(fn);
            switch (fa.type){
                case EType.One(et):
                    e=macro $e._each($et,${fa.fn});
                case EType.Pair(et1,et2):
                    e=macro $e._eachPair($et1,$et2,${fa.fn});
            }
        }
		return e;
    }

//	/**
//	 * Calls a function on each entry
//	 */
//	public macro function each(ethis:Expr, md:ExprOf<AMetadata>, fn:ExprOf<Dynamic -> Void> , ?fail:ExprOf<Bool>):ExprOf<Void> {
//		var te = fn.typeExpr();
//		var type:AType;
//		switch (te.t) {
//				case TFun(args, _):
//					if (args.length != 1) Context.error('function passed should have one argument', fn.pos);
//						if (args[0].t.match(TMono(_))) {
//							type = null;
//							fail = macro false;
//						}
//						else
//							type=args[0].t.aType();
//				case _:
//					Context.error(fn.toString()+' Should be a function T -> Void', fn.pos);
//		}
//		//TODO Fix this real dirty hack :S
//		var tt = (type==null)? macro null : Context.parse('Context.getType("$type")', fn.pos);
//
//		fail = (fail.isNull())?macro false:fail;
//		return macro Metas._each($ethis,$md,$tt,$fn,$fail);
//	}
//	#if macro
//	@:noCompletion @:dox(hide)
//	public static function _each<T>(meta:Metas,md:AMetadata, t:AType, fn:T -> Void,fail:Bool=false) {
//		//var all = meta.getAllExprFrom(md);
//		var all = meta.getAllFrom(md);
//		for (m in all) {
//			for (p in m.params) {
//				if (t!=null && !p.typeUnify(t))
//					if (fail)
//						Context.fatalError('Metadata check failed, expected `$t`', m.pos);
//					else continue;
//				fn(p.getValue());
//			}
//		}
//	}
//
//	#end
}
#end