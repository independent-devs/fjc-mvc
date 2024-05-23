// Import and register all your controllers from the importmap under controllers/*
import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading";
import CheckboxSelectAll from "@stimulus-components/checkbox-select-all";
import Dialog from "@stimulus-components/dialog";
import Popover from "@stimulus-components/popover";
import { application } from "controllers/application";
import Notification from "stimulus-notification";

// Registers
application.register("notification", Notification);
application.register("dialog", Dialog);
application.register("popover", Popover);
application.register("checkbox-select-all", CheckboxSelectAll);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
lazyLoadControllersFrom("controllers", application);
