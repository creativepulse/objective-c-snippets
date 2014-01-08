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
