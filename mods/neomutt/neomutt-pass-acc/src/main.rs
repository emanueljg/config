use clap::{Arg, ArgAction, Command, arg, builder::{EnumValueParser, PossibleValuesParser, PossibleValue}, value_parser, ValueEnum};
use gpgme::{Context, Protocol};
use std::{
    error::Error,
    fs::File,
    io::{self, prelude::*},
    path::PathBuf,
    env,
    path::Path,
    fmt,
};


#[derive(Clone, Debug)]
enum AccountKind {
    IMAPS,
    POPS,
    SMTPS,
    NNTPS,
}

impl AccountKind { }

impl clap::ValueEnum for AccountKind {
    fn value_variants<'a>() -> &'a [Self] {
        &[Self::IMAPS, Self::POPS, Self::SMTPS, Self::NNTPS]
    }

    fn to_possible_value(&self) -> Option<PossibleValue> {
        Some(match self {
            Self::IMAPS => PossibleValue::new("imaps"),
            Self::POPS => PossibleValue::new("pops"),
            Self::SMTPS => PossibleValue::new("smtps"),
            Self::NNTPS => PossibleValue::new("nntps"),
        })
    }
}

impl std::fmt::Display for AccountKind {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        self.to_possible_value()
            .expect("no values are skipped")
            .get_name()
            .fmt(f)
    }
}

fn cli() -> Command {
    Command::new("neomutt-pass-acc")
        .about("https://neomutt.org/feature/account-cmd")
        .arg(
            Arg::new("hostname")
                .long("hostname")
                .required(true)
        )
        .arg(
            Arg::new("username")
                .long("username")
                .required(true)
        )
        .arg(
            Arg::new("type")
                .long("type")
                .required(true)
                .value_parser(EnumValueParser::<AccountKind>::new())
        )
}


fn main() {
    let matches = cli().get_matches();
    let hostname: &String = matches.get_one("hostname")
        .expect("hostname must be specified");
    let username: &String = matches.get_one("username")
        .expect("username must be specified");
    let type_: &AccountKind = matches.get_one("type")
        .expect("type must be specified");

    eprintln!("{} {} {:?}", hostname, username, type_);

    let password_store_dir_env = &env::var("PASSWORD_STORE_DIR")
        .expect("could not get env var PASSWORD_STORE_DIR"); 
    let password_store_dir = Path::new(&password_store_dir_env);

    let secret_file = password_store_dir
        .join("neomutt")
        .join(username)
        .join::<String>(std::format!("{}.gpg", type_));

    let mut ctx = Context::from_protocol(Protocol::OpenPgp).unwrap();
    let mut input = File::open(secret_file).unwrap();
    let mut output = Vec::new();
    ctx.decrypt(&mut input, &mut output).unwrap();
    io::stdout().write_all(&output).unwrap();
}
