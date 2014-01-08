# Table view in iOS with item labels wrapped in two lines

Some times you need to write tables in iOS where single line labels are too short. If only you had a second line, the final experience would be much better.

In iOS, table items actually give you the option of a second line. The standard view for table items gives you two controls "textLabel" and "detailTextLabel", but the font size of the second is smaller than the first because it is supposed to be a sub-header.

The code in this article shows you how to adjust the font sizes of both labels so that they appear to be one single label wrapped in two lines.

In order to accomplish the separation of the source text in two labels we need to manually wrap it to two lines. We do that by taking an arbitrary length of a string that usually fits in one line, and cut the source text there. Before we make the final cut we make sure we don't break the last word. So we make the script go back a few characters in order not to leave the last word intact.

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *identifier = @"MyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:identifier];
            UIFont *font = [UIFont fontWithName:@"Helvetica" size:12.0];
            cell.textLabel.font = font;
            cell.detailTextLabel.font = font;
        }

        NSUInteger max_len = 45;
        NSString *str = [source_items objectAtIndex:indexPath.row];

        if ([str length] <= max_len) {
            cell.textLabel.text = str;
            cell.detailTextLabel.text = @"";
        }
        else {
            // find wrapping point
            NSInteger i = max_len;
            while (i > 0 && [str characterAtIndex:i] != ' ') {
                i--;
            }

            if (i == 0) {
                cell.textLabel.text = [str substringToIndex:max_len];
                cell.detailTextLabel.text = [str substringFromIndex:max_len];
            }
            else {
                cell.textLabel.text = [str substringToIndex:i];
                cell.detailTextLabel.text = [str substringFromIndex:(i + 1)];
            }
        }
        
        return cell;
    }

This article was originally published in [http://www.creativepulse.gr/en/blog/2014/table-view-in-ios-with-item-labels-wrapped-in-two-lines](http://www.creativepulse.gr/en/blog/2014/table-view-in-ios-with-item-labels-wrapped-in-two-lines)
