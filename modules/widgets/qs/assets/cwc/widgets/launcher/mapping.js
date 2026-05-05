function handleKeyPress(ev) {
	if (search.popupFocused) {
		list.currentItem.popup.handleInput(ev);
		return;
	}

	switch (ev.key) {
		case Qt.Key_Right:
			if (list.currentItem.popup.realVisible) {
				search.popupFocused = true;
				ev.accepted = true;
			}
			break;
		case Qt.Key_Up:
			if (config.data.topToBottom) list.decrementCurrentIndex();
			else list.incrementCurrentIndex();
			break;
		case Qt.Key_Down:
			if (config.data.topToBottom) list.incrementCurrentIndex();
			else list.decrementCurrentIndex();
			break;
		case Qt.Key_Return:
		case Qt.Key_Enter:
			if (window.apps?.length) {
				window.realVisible = false;
				list.currentItem.launch();
			}
			break;
		case Qt.Key_Escape:
			window.realVisible = false;
			break;
	}

	if (ev.modifiers & Qt.ControlModifier && ev.key === Qt.Key_W) {
		search.text = search.text.split(" ").slice(0, -1).join(" ");
	}
}

function handleActionsPopupKeyPress(ev) {
	switch (ev.key) {
		case Qt.Key_Left:
			search.popupFocused = false;
			ev.accepted = true;
			break;
		case Qt.Key_Up:
			popup.currentIndex = Math.max(popup.currentIndex - 1, 0);
			break;
		case Qt.Key_Down:
			popup.currentIndex = Math.min(
				popup.currentIndex + 1,
				popup.actions.length - 1,
			);
			break;
		case Qt.Key_Return:
		case Qt.Key_Enter:
			list.currentItem.launch(popup.actions[popup.currentIndex]);
			window.realVisible = false;
			break;
		case Qt.Key_Escape:
			window.realVisible = false;
			break;
	}
}
