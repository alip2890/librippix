[+ AutoGen5 template h +]
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

#ifndef RIPPIX_ERR_H
#define RIPPIX_ERR_H

typedef enum {
[+ FOR errlist "," +]
  ERR_[+ (string-upcase! (get "errlist_key")) +] [+
  ENDFOR errlist +]
} RippixErrCode;

typedef enum {
[+ FOR dialoglist "," +]
  DLG_[+ (string-upcase! (get "dialoglist_key")) +] [+
  ENDFOR dialoglist +]
} RippixDialogCode;

typedef enum {
[+ FOR statuslist "," +]
  STAT_[+ (string-upcase! (get "statuslist_key")) +] [+
  ENDFOR statuslist +]
} RippixStatusCode;

/* Returns the error string for error code specified by err_code. */
const char*
get_err_string (RippixErrCode err_code);

/* Returns the status string for status code specified by stat_code. */
const char*
get_stat_string (RippixStatusCode stat_code);

/* Returns the primary dialog string (suitable for dialog title, etc.)
   for dialog code specified by dlg_code. */
const char*
get_dlg_prim_string (RippixDialogCode dlg_code);

/* Returns the secondary dialog string (suitable for main dialog widget, etc.)
   for dialog code specified by dlg_code. */
const char*
get_dlg_sec_string (RippixDialogCode dlg_code);

/* It is recommended to call the following three functions early in the main
   function. This ensures that no important messages are missed. */

/* Registers a callback function so that error messages can be displayed in the
   frontend. Error messages are also always printed on the standard output.
   The first argument for the callback function is the error message to be displayed.
*/
void
register_error_cb (void (*cb)(const char*));

/* Registers a callback function so that status messages can be displayed in the
   frontend. Status messages are not printed on the standard output.
   The first argument for the callback function is the status message. */
void
register_status_cb (void (*cb)(const char*));

/* Registers a callback function which is called when the user has to enter
   additional data. If no callback is registered, the program will terminate.
   The first argument for the callback function is a short text, suitable for
   dialog title. The second argument is the main text.
   If the third argument is set to true, the user has to enter some text.
   The callback must return the data the user entered. */
void
register_dialog_cb (char* (*cb)(const char*, const char*, int));

void
emit_error (RippixErrCode err_code, const char *extra_msg);

void
emit_status (RippixStatusCode stat_code, const char *extra_msg);

char*
emit_dialog (RippixDialogCode dialog_code, int with_input);

#endif /* !RIPPIX_ERR_H */
