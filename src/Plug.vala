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

public class NotificationsPlug : Switchboard.Plug {
	private Gtk.Stack stack;

	private Widgets.MainView main_view;
	private Granite.Widgets.AlertView alert_view;

	public NotificationsPlug () {
		Object (category: Category.PERSONAL,
			code_name: "personal-pantheon-notifications",
			display_name: _("Notifications"),
			description: _("Enable or disable notifications."),
			icon: "preferences-desktop-notifications");
	}

	public override Gtk.Widget get_widget () {
		if (stack != null) {
			return stack;
		}

		build_ui ();

		return stack;
	}

	public override void shown () {
		
	}

	public override void hidden () {
		
	}

	public override void search_callback (string location) {
		
	}

	public override async Gee.TreeMap<string, string> search (string search) {
		return new Gee.TreeMap<string, string> (null, null);
	}

	private void build_ui () {
		stack = new Gtk.Stack ();

		main_view = new Widgets.MainView ();
		alert_view = create_alert_view ();

		main_view.show_all ();
		alert_view.show_all ();

		stack.add_named (main_view, "main-view");
		stack.add_named (alert_view, "alert-view");

		stack.show_all ();
	}

	private Granite.Widgets.AlertView create_alert_view () {
		var title = _("Nothing to do here");

		var description = _("Notifications preferences are for configuring which apps make use of notifications, for changing how an app's notifications appear,\nand for setting when you do not want to be disturbed by notifications.");
		description += "\n\n";
		description += _("When apps are installed that have notification options they will automatically appear here.");

		var icon_name = "dialog-information";

		return new Granite.Widgets.AlertView (title, description, icon_name);
	}
}

public Switchboard.Plug get_plug (Module module) {
	debug ("Activating Notifications plug");
	var plug = new NotificationsPlug ();
	return plug;
}
