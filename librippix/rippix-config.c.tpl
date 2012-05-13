[+ AutoGen5 template c +]
/* Copyright (C) 2012
   Aljosha Papsch <papsch.al@googlemail.com>

   Configuration API for Rippix. The backend must be provided by the frontend.

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

#include <rippix-config.h>

const struct
{
  char *key;
  ConfValueType type;
} rx_configlist[] =
  {
    [+ FOR configlist "," +]
    { "[+configlist_value+]", [+configlist_type+] } [+
    ENDFOR configlist +]
  };

/* Callback function for reading from configuration */
void* (*cfgread_cb)(const char*);
/* Callback function for writing to configuration */
int (*cfgwrite_cb)(const char*, const ConfValueType, const void*);

const char*
get_conf_key_string (RippixConfigKey key)
{
  return rx_configlist[key].key;
}

const ConfValueType
get_conf_key_type (RippixConfigKey key)
{
  return rx_configlist[key].type;
}

void
register_cfgread_cb (void* (*cb)(const char*))
{
  cfgread_cb = cb;
}

void
register_cfgwrite_cb (int (*cb)(const char*, const ConfValueType, const void*))
{
  cfgwrite_cb = cb;
}

void*
config_read (RippixConfigKey key)
{
  return cfgread_cb (get_conf_key_string (key));
}

int
config_write (RippixConfigKey key,
	      const void *data_value)
{
  return cfgwrite_cb (get_conf_key_string (key), get_conf_key_type (key),
		      data_value);
}
