[+ AutoGen5 template c +]
/* Copyright (C) 2011
   Aljosha Papsch <papsch.al@googlemail.com>

   Returns strings from error and status codes. Calls a frontend function
   when user action is required.

   This file is part of librippix.

   librippix is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   librippix is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with librippix.  If not, see <http://www.gnu.org/licenses/>. */

#include <stdlib.h>
#include <stdio.h>
#include <error.h>

#include <config.h>
#include <rippix-err.h>

const char *rx_errlist[] =
  {
    [+ FOR errlist "," +]
    "[+errlist_value+]" [+
    ENDFOR errlist +]
  };

const char *rx_statlist[] =
  {
    [+ FOR statuslist "," +]
    "[+statuslist_value+]" [+
    ENDFOR statuslist +]
  };

const struct
{
  char *primary;
  char *secondary;
} rx_dlglist[] =
  {
    [+ FOR dialoglist "," +]
    { "[+dialoglist_prim+]", "[+dialoglist_sec+]" }
    [+ ENDFOR dialoglist +]
  };

void (*error_cb)(const char*);
void (*status_cb)(const char*);
char* (*dialog_cb)(const char*, const char*, int);

const char*
get_err_string (RippixErrCode err_code)
{
  return rx_errlist[err_code];
}

const char*
get_stat_string (RippixStatusCode stat_code)
{
  return rx_statlist[stat_code];
}

const char*
get_dlg_prim_string (RippixDialogCode dlg_code)
{
  return rx_dlglist[dlg_code].primary;
}

const char*
get_dlg_sec_string (RippixDialogCode dlg_code)
{
  return rx_dlglist[dlg_code].secondary;
}

void
register_error_cb (void (*cb)(const char*))
{
  error_cb = cb;
}

void
register_status_cb (void (*cb)(const char*))
{
  status_cb = cb;
}

void
register_dialog_cb (char* (*cb)(const char*, const char*, int))
{
  dialog_cb = cb;
}

void
emit_error (RippixErrCode err_code, const char *extra_msg)
{
  if (error_cb == NULL)
    {
      error (0, 0, "no error callback defined, aborting");
      exit (1);
    }
  const char *err_msg = get_err_string (err_code);
  error (0, 0, "%s\n%s", err_msg, extra_msg);
  error_cb (err_msg);
}

void
emit_status (RippixStatusCode stat_code, const char *extra_msg)
{
  const char *stat_msg = get_stat_string (stat_code);
  if (status_cb == NULL)
    {
      error (0, 0, "no status callback defined");
    }
  else
    {
      status_cb (stat_msg);
    }
  printf ("%s status message: %s\n", PACKAGE_NAME, stat_msg);
}

char*
emit_dialog (RippixDialogCode dialog_code, int with_input)
{
  if (dialog_cb == NULL)
    {
      error (0, 0, "no dialog callback defined, aborting");
      exit (1);
    }
  const char *dlg_primary = get_dlg_prim_string (dialog_code);
  const char *dlg_secondary = get_dlg_sec_string (dialog_code);
  return dialog_cb (dlg_primary, dlg_secondary, with_input);
}
