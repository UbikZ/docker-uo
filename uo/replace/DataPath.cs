using System;
using System.IO;
using Microsoft.Win32;
using Server;

namespace Server.Misc
{
	public class DataPath
	{
		/* If you have not installed Ultima Online,
		 * or wish the server to use a separate set of datafiles,
		 * change the 'CustomPath' value.
		 * Example:
		 *  private static string CustomPath = @"C:\Program Files\Ultima Online";
		 */
		private static string CustomPath = null;

		/* The following is a list of files which a required for proper execution:
		 *
		 * Multi.idx
		 * Multi.mul
		 * VerData.mul
		 * TileData.mul
		 * Map*.mul or Map*LegacyMUL.uop
		 * StaIdx*.mul
		 * Statics*.mul
		 * MapDif*.mul
		 * MapDifL*.mul
		 * StaDif*.mul
		 * StaDifL*.mul
		 * StaDifI*.mul
		 */

		public static void Configure()
		{
			Core.DataDirectories.Add( "./Data" );
		}

		private static string GetPath( string subName, string keyName )
		{
			try
			{
				string keyString;

				if( Core.Is64Bit )
					keyString = @"SOFTWARE\Wow6432Node\{0}";
				else
					keyString = @"SOFTWARE\{0}";

				using( RegistryKey key = Registry.LocalMachine.OpenSubKey( String.Format( keyString, subName ) ) )
				{
					if( key == null )
						return null;

					string v = key.GetValue( keyName ) as string;

					if( String.IsNullOrEmpty( v ) )
						return null;

					if ( keyName == "InstallDir" )
						v = v + @"\";

					v = Path.GetDirectoryName( v );

					if ( String.IsNullOrEmpty( v ) )
						return null;

					return v;
				}
			}
			catch
			{
				return null;
			}
		}
	}
}
