using OWML.Common;
using OWML.ModHelper;

namespace IcelandicTranslation
{
    public class IcelandicTranslation : ModBehaviour
    {
        private void Awake()
        {
            // You won't be able to access OWML's mod helper in Awake.
            // So you probably don't want to do anything here.
            // Use Start() instead.
        }

        private void Start()
        {
            // Starting here, you'll have access to OWML's mod helper.
            ModHelper.Console.WriteLine($"{nameof(IcelandicTranslation)} is loaded!", MessageType.Success);

            var api = ModHelper.Interaction.TryGetModApi<ILocalizationAPI>("xen.LocalizationUtility");
            api.RegisterLanguage(this, "Íslenska", "assets/Translation.xml");
        }
    }
}
