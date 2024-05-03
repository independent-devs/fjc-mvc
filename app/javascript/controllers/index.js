// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application";
import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading";
import Notification from "stimulus-notification";
import Dialog from '@stimulus-components/dialog';
import Popover from '@stimulus-components/popover';

// Registers
application.register("notification", Notification);
application.register('dialog', Dialog);
application.register('popover', Popover);

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
lazyLoadControllersFrom("controllers", application);
