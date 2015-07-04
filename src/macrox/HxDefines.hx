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
	/**Print absolute file path in trace output */
	var AbsolutePath="absolute-path";
	/**Allow the SWF to be measured with Monocle tool */
	var AdvancedTelemetry="advanced-telemetry";
	/**Use static analyzer for optimization (experimental) */
	var Analyzer="analyzer";
	/**Defined when outputing flash9 as3 source code */
	var As3="as3";
	/**Check the used fields of the xml proxy */
	var CheckXmlProxy="check-xml-proxy";
	/**Defined in the core api context */
	var CoreApi="core-api";
	/**Mark some generated core api classes with the Serializable attribute on C# */
	var CoreApiSerialize="core-api-serialize";
	/**Generate experimental cpp instruction assembly */
	var Cppia="cppia";
	/**<mode:std|full||no> Set the dead code elimination mode (default std) */
	var Dce="dce";
	/**Show DCE log */
	var DceDebug="dce-debug";
	/**Activated when compiling with -debug */
	var Debug="debug";
	/**Activated during completion */
	var Display="display";
	/**GenCPP experimental linking */
	var DllExport="dll-export";
	/**GenCPP experimental linking */
	var DllImport="dll-import";
	/**Do not perform any removal/change in order to correctly generate documentation */
	var DocGen="doc-gen";
	/**Dump the complete typed AST for internal debugging in a dump subdirectory - use dump=pretty for Haxe-like formatting */
	var Dump="dump";
	/**Dump the classes dependencies in a dump subdirectory */
	var DumpDependencies="dump-dependencies";
	/**Remove variable IDs from non-pretty dumps (helps with diff) */
	var DumpIgnoreVarIds="dump-ignore-var-ids";
	/**Erase generic classes on C# */
	var EraseGenerics="erase-generics";
	/**Enable full flash debug infos for FDB interactive debugging */
	var Fdb="fdb";
	/**Output filename extension for cpp source code */
	var FileExtension="file-extension";
	/**More strict typing for flash target */
	var FlashStrict="flash-strict";
	/**Keep the SWF library initial stage */
	var FlashUseStage="flash-use-stage";
	/**Force the compiler to check -net-lib and -java-lib added classes (internal) */
	var ForceLibCheck="force-lib-check";
	/**Tag all properties with :nativeProperty metadata for 3.1 compatibility */
	var ForceNativeProperty="force-native-property";
	/**Print a warning for each formated string, for 2.x compatibility */
	var FormatWarning="format-warning";
	/**GenCommon internal */
	var GencommonDebug="gencommon-debug";
	/**Given the name 'haxe' to the flash boot class instead of a generated name */
	var HaxeBoot="haxe-boot";
	/**The current Haxe version value */
	var HaxeVer="haxe-ver";
	/**Provided to allow compatibility between hxcpp versions */
	var HxcppApiLevel="hxcpp-api-level";
	/**prepend path to generated include files */
	var IncludePrefix="include-prefix";
	/**The code is compiled to be run with --interp */
	var Interp="interp";
	/**<version:5-7> Sets the Java version to be targeted */
	var JavaVer="java-ver";
	/**Don't use a function wrapper and strict mode in JS output */
	var JsClassic="js-classic";
	/**Generate JS for ES5-compliant runtimes */
	var JsEs5="js-es5";
	/**Generate nested objects for packages and types */
	var JsUnflatten="js-unflatten";
	/**Keep old source files in the output directory (for C#/Java) */
	var KeepOldOutput="keep-old-output";
	/**Maximum cost (number of expressions * iterations) before loop unrolling is canceled (default 250) */
	var LoopUnrollMaxCost="loop-unroll-max-cost";
	/**Defined when code is compiled in the macro context */
	var Macro="macro";
	/**Display per-macro timing when used with --times */
	var MacroTimes="macro-times";
	/**Output neko source instead of bytecode */
	var NekoSource="neko-source";
	/**Keep Neko 1.x compatibility */
	var NekoV1="neko-v1";
	/**<name> Sets the .NET target. Defaults to "net". xbox, micro (Micro Framework), compact (Compact Framework) are some valid values */
	var NetTarget="net-target";
	/**<version:20-45> Sets the .NET version to be targeted */
	var NetVer="net-ver";
	/**Use local network sandbox instead of local file access one */
	var NetworkSandbox="network-sandbox";
	/**Disable final compilation for Cs, Cpp and Java */
	var NoCompilation="no-compilation";
	/**Disable completion optimization (for debug purposes) */
	var NoCopt="no-copt";
	/**Remove all debug macros from cpp output */
	var NoDebug="no-debug";
	/**Do not warn if fields annotated with @:deprecated are used */
	var NoDeprecationWarnings="no-deprecation-warnings";
	/**Change overrides on some basic classes into HX suffixed methods, flash only */
	var NoFlashOverride="no-flash-override";
	/**Disable inlining */
	var NoInline="no-inline";
	/**Disable macro context caching */
	var NoMacroCache="no-macro-cache";
	/**Disable optimizations */
	var NoOpt="no-opt";
	/**Disable pattern matching */
	var NoPatternMatching="no-pattern-matching";
	/**Generate top-level types into haxe.root namespace */
	var NoRoot="no-root";
	/**Disable simplification filter */
	var NoSimplify="no-simplify";
	/**Disable SWF output compression */
	var NoSwfCompress="no-swf-compress";
	/**Disable all trace calls */
	var NoTraces="no-traces";
	/**Sets the hxcpp output to objective-c++ classes. Must be defined for interop */
	var Objc="objc";
	/**Compiled with --php-prefix */
	var PhpPrefix="php-prefix";
	/**Disables haxe source mapping when targetting C# */
	var RealPosition="real-position";
	/**GenCommon internal */
	var ReplaceFiles="replace-files";
	/**GenCPP internal */
	var Scriptable="scriptable";
	/**Expose types to surrounding scope of Haxe generated closure without writing to window object */
	var ShallowExpose="shallow-expose";
	/**Print value as comment on top of generated files, use '' value to disable */
	var SourceHeader="source-header";
	/**Include the hx sources as part of the JS source map */
	var SourceMapContent="source-map-content";
	/**Output a SWC instead of a SWF */
	var Swc="swc";
	/**<level:1-9> Set the amount of compression for the SWF output */
	var SwfCompressLevel="swf-compress-level";
	/**Set a password for debugging */
	var SwfDebugPassword="swf-debug-password";
	/**Use hardware acceleration to blit graphics */
	var SwfDirectBlit="swf-direct-blit";
	/**Use GPU compositing features when drawing graphics */
	var SwfGpu="swf-gpu";
	/**<file> Include contents of <file> as metadata in the swf */
	var SwfMetadata="swf-metadata";
	/**Insert empty first frame in swf */
	var SwfPreloaderFrame="swf-preloader-frame";
	/**Compile Haxe private as protected in the SWF instead of public */
	var SwfProtected="swf-protected";
	/**Maximum ActionScript processing time before script stuck dialog box displays (in seconds) */
	var SwfScriptTimeout="swf-script-timeout";
	/**Use DoAbc swf-tag instead of DoAbcDefine */
	var SwfUseDoabc="swf-use-doabc";
	/**Defined for all system platforms */
	var Sys="sys";
	/**Allow unsafe code when targeting C# */
	var Unsafe="unsafe";
	/**Use nekoc compiler instead of internal one */
	var UseNekoc="use-nekoc";
	/**Allows access to documentation during compilation */
	var UseRttiDoc="use-rtti-doc";
	/**GenCPP internal */
	var Vcproj="vcproj";

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