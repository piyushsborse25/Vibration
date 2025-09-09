import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;
import java.util.*;

public class MainTest {

    // Test based on the sample input given in the problem
    @Test
    public void testSampleInput() {
        ArrayList<String> input = new ArrayList<>(Arrays.asList(
            "Arjun Sharma, MakeMyTrip, 1, Deluxe Room, Rs 8500, Cash",
            "Priya Nair, Booking.com, 1, Executive Suite, Rs 15000, Credit Card",
            "Arjun Sharma, Agoda, 3, Standard Room, Rs 7500, Cash",
            "Kavya Reddy, Expedia, 4, Superior Room, Rs 6000, Credit Card",
            "Rajesh Kumar, MakeMyTrip, 5, Executive Suite, Rs 6500, Credit Card",
            "Vikram Joshi, Booking.com, 10, Presidential Suite, Rs 25000, Credit Card",
            "Arjun Sharma, Expedia, 21, Deluxe Room, Rs 6500, Credit Card",
            "Arjun Sharma, MakeMyTrip, 22, Standard Room, Rs 7500, UPI",
            "Anita Reddy, Agoda, 23, Superior Room, Rs 7000, Cash",
            "Kavya Reddy, Booking.com, 24, Executive Suite, Rs 8000, UPI",
            "Priya Nair, Expedia, 25, Superior Room, Rs 7500, UPI"
        ));
        List<String> expected = Arrays.asList("Priya Nair", "Vikram Joshi");
        List<String> actual = Main.processData(input);
        assertEquals(expected, actual);
    }

    // Test empty input
    @Test
    public void testEmptyInput() {
        ArrayList<String> input = new ArrayList<>();
        List<String> actual = Main.processData(input);
        assertTrue(actual.isEmpty());
    }

    // Test single customer who paid max for all rooms
    @Test
    public void testSingleCustomerMax() {
        ArrayList<String> input = new ArrayList<>(Arrays.asList(
            "Alice, HotelX, 1, Suite, Rs 5000, Cash"
        ));
        List<String> expected = Arrays.asList("Alice");
        List<String> actual = Main.processData(input);
        assertEquals(expected, actual);
    }

    // Test single customer who paid discounted price
    @Test
    public void testSingleCustomerDiscounted() {
        ArrayList<String> input = new ArrayList<>(Arrays.asList(
            "Bob, HotelY, 1, Deluxe, Rs 4000, Cash",
            "Charlie, HotelY, 2, Deluxe, Rs 4500, Credit Card"
        ));
        List<String> expected = Arrays.asList("Charlie");
        List<String> actual = Main.processData(input);
        assertEquals(expected, actual);
    }

    // Test multiple bookings with tie on max price
    @Test
    public void testMultipleCustomersTieMax() {
        ArrayList<String> input = new ArrayList<>(Arrays.asList(
            "Dave, HotelZ, 1, Standard, Rs 3000, Cash",
            "Eve, HotelZ, 2, Standard, Rs 3000, Credit Card"
        ));
        List<String> expected = Arrays.asList("Dave", "Eve");
        List<String> actual = Main.processData(input);
        assertEquals(expected, actual);
    }

    // Test customer with mixed max and discounted bookings
    @Test
    public void testCustomerMixedPayments() {
        ArrayList<String> input = new ArrayList<>(Arrays.asList(
            "Frank, HotelA, 1, Deluxe, Rs 6000, Cash",
            "Frank, HotelB, 2, Executive, Rs 5500, Credit Card",
            "Grace, HotelA, 3, Deluxe, Rs 6000, Credit Card",
            "Grace, HotelB, 4, Executive, Rs 5000, Cash"
        ));
        List<String> expected = Arrays.asList("Frank");
        List<String> actual = Main.processData(input);
        assertEquals(expected, actual);
    }
}