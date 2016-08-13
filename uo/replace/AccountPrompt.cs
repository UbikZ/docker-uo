using System;
using Server;
using Server.Accounting;

namespace Server.Misc
{
	public class AccountPrompt
	{
		public static void Initialize()
		{
			string username = "__UO_ADMIN_USERNAME__";
			string password = "__UO_ADMIN_PASSWORD__";

			if ( Accounts.Count == 0 && !Core.Service )
			{
				Console.WriteLine( "This server has no accounts. Creating default admin account." );
				Console.WriteLine( "Username: {0} / Password {1}", username, password );

				Account a = new Account( username, password );
				a.AccessLevel = AccessLevel.Owner;

				Console.WriteLine( "Account created." );
			}
		}
	}
}
