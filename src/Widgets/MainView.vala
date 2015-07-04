/***
	BEGIN LICENSE

	Copyright (C) 2014-2015 elementary Developers
	This program is free software: you can redistribute it and/or modify it
	under the terms of the GNU Lesser General Public License version 3, as published
	by the Free Software Foundation.

	This program is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranties of
	MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR
	PURPOSE.  See the GNU General Public License for more details.

	You should have received a copy of the GNU General Public License along
	with this program.  If not, see <http://www.gnu.org/licenses/>

	END LICENSE

	Written By: Marcus Wichelmann <admin@marcusw.de>
***/

public class Widgets.MainView : Gtk.Paned {
	private Sidebar sidebar;

	private Gtk.Stack content;

	private AppSettingsView app_settings_view;
	private Granite.Widgets.AlertView alert_view;

	public MainView () {
		build_ui ();
		update_view ();
		connect_signals ();
	}

	private void build_ui () {
		sidebar = new Sidebar ();

		content = new Gtk.Stack ();

		app_settings_view = new AppSettingsView ();
		alert_view = create_alert_view ();

		app_settings_view.show_all ();
		alert_view.show_all ();

		content.add_named (app_settings_view, "app-settings-view");
		content.add_named (alert_view, "alert-view");

		this.pack1 (sidebar, true, false);
		this.pack2 (content, true, false);
		this.set_position (240);
	}

	private void connect_signals () {
		Backend.NotifyManager.get_default ().notify["do-not-disturb"].connect (update_view);
	}

	private void update_view () {
		content.set_visible_child_name (Backend.NotifyManager.get_default ().do_not_disturb ? "alert-view" : "app-settings-view");
	}

	private Granite.Widgets.AlertView create_alert_view () {
		var title = _("elementary OS is in Do Not Disturb mode");

		var description = _("While in Do Not Disturb mode, notifications and alerts will be hidden and notification sounds will be silenced.");
		description += "\n\n";
		description += _("System notifications, such as volume and display brightness, will be unaffected.");

		var icon_name = "notification-disabled";

		return new Granite.Widgets.AlertView (title, description, icon_name);
	}
}
