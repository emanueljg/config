{ custom, ... }:
{
  imports = [ custom.gpg-keys ];

  custom.gpg-keys = {
    masterKeys = {
      "personal" = {
        fullname = "Emanuel Johnson Godin";
        username = "emanueljg";
        key = "5AB5C730CBDD2B97C2AA04F98732051107C3695E";
        email = "emanueljohnsongodin@gmail.com";
        subKeys = {
          "kagari" = {
            sign = "5AA3CEA4D0D793A4D7436FF66E5CCF8E97D881D2!";
            encrypt = "691AC02D1D8BC43E9DAEB1B377BFECCDA6F08422!";
          };
          "getsuga" = {
            sign = "3E84C9AB8DB8129FE7331EABDF21265C1F0DF251!";
            encrypt = "F452E84F225E327236F968176C7D7B325A0F39FF!";
          };
          "kurohitsugi" = {
            sign = "AF579D9FBE44609BF096BFBCF69889812CE5659C!";
            encrypt = "7331B679C6F44F0B31D71D85AB20A842D67226BE!";
          };
        };
      };
    };
  };
}
