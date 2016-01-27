import sys.FileSystem;
import sys.io.File;

class RunAll
{
   public static function findRecurse(inPath:String, inPackage:String,inFilter:String->Bool,outClasses:Array<String>)
   {
      for(file in FileSystem.readDirectory(inPath))
      {
         if (file.substr(0,1)!="." && inFilter(file))
         {
            var test = inPath+"/"+file;

            if (FileSystem.isDirectory(test))
               findRecurse(test,inPackage+"."+file,inFilter,outClasses);
            else
            {
               var hxName = inPackage+"."+file;
               if (hxName.substr(hxName.length-3)==".hx")
                  outClasses.push( hxName.substr(0,hxName.length-3) );
            }
         }
      }
   }

   static function filter(inName:String):Bool
   {
      return inName!="android" && inName!="native";
   }

   public static function main()
   {
      Sys.println('Find classes...');
      var classes = new Array<String>();
      findRecurse("../nme","nme",filter,classes);
      findRecurse("../haxe","haxe",filter,classes);

      Sys.println('Create test...');
      var lines = new Array<String>();
      for(cls in classes)
         lines.push('import $cls;');
      lines.push("class ImportAll extends Sprite");
      lines.push("{");
      lines.push("   public function new() super();");
      lines.push("}");

      FileSystem.createDirectory("import-all");
      Sys.setCwd("import-all");
      File.saveContent("ImportAll.hx", lines.join("\n"));

      Sys.println('Build test...');
      var result = Sys.command("haxelib",["run","nme","build","cpp"]);
      Sys.println('Built with result $result.');
      Sys.exit(result);
   }
}
