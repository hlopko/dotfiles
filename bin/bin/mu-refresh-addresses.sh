#!/bin/sh

sentbox="~/.mail/fastmail/INBOX.Sent\ Items"

mu index --nocleanup --maildir="${sentbox}" --muhome=~/.mu-sent-index
