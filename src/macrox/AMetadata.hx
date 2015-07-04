package macrox;


#if macro
import haxe.extern.EitherType;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Context;

using macrox.Tools;

/**
 * AMetadata is an abstract to either MetaAccess or Metadata.
 *
 * It can be casted from many types that support metadata
 * ```haxe
 * var am1:AMetadata=Context.getLocalClass();
 * var am2:AMetadata=Context.getBuildFields()[0];
 * ```
 * @see [`haxe.macro.MetaAccess`](http://api.haxe.org/haxe/macro/MetaAccess.html)
 * @see [`haxe.macro.Metadata`](http://api.haxe.org/haxe/macro/Metadata.html)
 */
abstract AMetadata(EitherType<Metadata,MetaAccess>) from EitherType<Metadata,MetaAccess> {
	//TODO maybe public or use @:dox(show)
	@:from static function fromAType(at:AType) return fromBaseType(at);
	@:from static function fromBaseType(baseType:BaseType) return cast baseType.meta;
	@:from static function fromRefBaseType(baseType:Ref<BaseType>) return cast baseType.get().meta;	
	@:from static function fromClassField(classField:ClassField) return cast classField.meta;	
	@:from static function fromEnumField(enumField:EnumField) return cast enumField.meta;	
	@:from static function fromField(field:Field) return cast field.meta;
	@:from static function fromTypeDefinition(td:TypeDefinition) return cast td.meta;
	
	@:to public function toMetadata():Metadata {
		return Std.is(this, Metadata)?this: (this : MetaAccess).get();
	}
	/**
	 * Check if metadata exists
	 */
	public inline function has(name:String) {
		return if (Std.is(this, Metadata)) _getMeta(name) != null;				
			   else            			   (this : MetaAccess).has(name);	
	}
	/**
	 * Get the specified entry
	 */
	public inline function get(name:String):Null<MetadataEntry> {
		return if (Std.is(this, Metadata)) _getMeta(name);				
			   else            			   (this : MetaAccess).extract(name)[0];
	}	
	/**
	 * Get all entries
	 */
	public inline function getAll(name:String):Array<MetadataEntry> {
		return if (Std.is(this, Metadata)) [for (meta in (this : Metadata)) if (meta.name == name) meta];			
			   else            			   (this : MetaAccess).extract(name);
	}	
	/**
	 * Get all entries expressions
	 */
	public inline function getAllExpr(name:String): Array<Expr> 
		return [for (m in getAll(name)) for (p in m.params) p];
		
	/**
	 * Get all values
	 */
	public inline function getAllValue(name:String): Array<Dynamic> 
		return [for (m in getAll(name)) for (p in m.params) p.getValue()];
	
	
	/**
	 * Add a meta
	 */
	public function add( name : String, params : Array<Expr>=null, pos : Position =null):Void {
		if (params == null) params = [];
		if (pos == null) pos = Context.currentPos();
		if (Std.is(this, Metadata)) 
			(this : Metadata).push({name:name, params:params, pos:pos});			
		else            			   
			(this : MetaAccess).add(name, params, pos);
	}
	/**
     * Push a [`haxe.macro.MetadataEntry`](http://api.haxe.org/haxe/macro/MetadataEntry.html) to this metadata
     */
	public function push(me:MetadataEntry):Void{
        if (Std.is(this, Metadata))
            (this : Metadata).push(me);
        else
            (this : MetaAccess).add(me.name, me.params, me.pos);
    }
	/**
	 * Remove this meta
	 */
	public inline function remove(name:String) {
		if (Std.is(this, Metadata)) _removeMeta(name);		
		else            			(this : MetaAccess).remove(name);	
	}
	
	function _getMeta(name:String):Null<MetadataEntry> {
		for (meta in (this : Metadata)) 
			if (meta.name == name) 
				return meta;
		return null;
	}	
	
	function _removeMeta(name:String) {
		for (meta in (this : Metadata)) 
			if (meta.name == name) 
				(this : Metadata).remove(meta);	
	}
	
}

#end
