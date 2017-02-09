using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Nuba.Startup))]
namespace Nuba
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
