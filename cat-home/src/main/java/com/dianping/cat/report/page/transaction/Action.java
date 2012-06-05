package com.dianping.cat.report.page.transaction;

public enum Action implements com.site.web.mvc.Action {
	HOURLY_REPORT("view"),

	GRAPHS("graphs"),

	MOBILE("mobile"),

	MOBILE_GRAPHS("mobile_graphs"),

	HISTORY_REPORT("history");
	
	private String m_name;

	private Action(String name) {
		m_name = name;
	}

	public static Action getByName(String name, Action defaultAction) {
		for (Action action : Action.values()) {
			if (action.getName().equals(name)) {
				return action;
			}
		}

		return defaultAction;
	}

	@Override
	public String getName() {
		return m_name;
	}
}
