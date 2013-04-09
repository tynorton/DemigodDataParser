using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
/// Generic way to create a single instance of the specified class class.
/// </summary>
/// <remarks>
/// Enforces private/protected constructors, and uses double locking.
/// </remarks>
public static class Singleton<T> where T : class
{
    static volatile T s_instance;
    static object s_lock = new object();

    static Singleton()
    {
    }

    public static T Instance
    {
        get
        {
            if (s_instance == null)
            {
                lock (s_lock)
                {
                    if (s_instance == null)
                    {
                        ConstructorInfo constructor = null;

                        // Binding flags exclude public constructors.
                        constructor = typeof(T).GetConstructor(BindingFlags.Instance | BindingFlags.NonPublic, null, new Type[0], null);

                        // Also exclude internal constructors.
                        if (constructor == null || constructor.IsAssembly)
                        {
                            throw new Exception(string.Format("A private or protected constructor is missing for '{0}'.", typeof(T).Name));
                        }

                        s_instance = (T)constructor.Invoke(null);
                    }
                }
            }

            return s_instance;
        }
    }
}