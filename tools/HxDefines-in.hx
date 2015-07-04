package macrox;

#if macro
import haxe.macro.Context;

/**
 * Contains all Haxe compiler defines
 * This file is generated with the output of `haxe --help-defines` by Script.hx using HxDefines-in.hx
 * ```haxe
 * HxDefines.Debug.defined();
 * var dce=HxDefines.Dce.value();
 * ```
 * @see http://haxe.org/manual/lf-condition-compilation-flags.html
 */
@:enum
abstract HxDefines(String) to String{
	/*gen-content*/
	/**
	 * Check if this compiler flag is defined
     */
	@:to public inline function defined() return Context.defined(this);
	/**
      * Get the value of this compiler flag
      */
	public inline function value() return Context.definedValue(this);
	/**
	 * Get a custom compiler flag like `HxDefines.get("test").defined();`
	 */
	@:from public static inline function get(name:String):HxDefines return cast name; 
}
#end